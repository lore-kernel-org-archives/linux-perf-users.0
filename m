From: Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH v2 4/5] tools api: add a lightweight buffered reading api
Date: Sat, 4 Apr 2020 12:06:45 +0900
Message-ID: <CAM9d7cgCyatYvH98m8DYiAe1CapqW8Sfu8VtwnF24kJQbUvG=Q@mail.gmail.com>
References: <20200402154357.107873-1-irogers@google.com> <20200402154357.107873-5-irogers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200402154357.107873-5-irogers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Petr Mladek <pmladek@suse.com>, Andrey Zhizhikin <andrey.z@gmail.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, Thomas Gleixner <tglx@linutronix.de>, Kan Liang <kan.liang@linux.intel.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-perf-users <linux-perf-users@vger.kernel.org>, Stephane Eranian <eranian@google.com>
List-Id: linux-perf-users.vger.kernel.org

Hello,

On Fri, Apr 3, 2020 at 12:44 AM Ian Rogers <irogers@google.com> wrote:
>
> The synthesize benchmark shows the majority of execution time going to
> fgets and sscanf, necessary to parse /proc/pid/maps. Add a new buffered
> reading library that will be used to replace these calls in a follow-up
> CL.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/lib/api/io.h | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 107 insertions(+)
>  create mode 100644 tools/lib/api/io.h
>
> diff --git a/tools/lib/api/io.h b/tools/lib/api/io.h
> new file mode 100644
> index 000000000000..5aa5b0e26a7a
> --- /dev/null
> +++ b/tools/lib/api/io.h
> @@ -0,0 +1,107 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Lightweight buffered reading library.
> + *
> + * Copyright 2019 Google LLC.
> + */
> +#ifndef __API_IO__
> +#define __API_IO__
> +
> +struct io {
> +       /* File descriptor being read/ */
> +       int fd;
> +       /* Size of the read buffer. */
> +       unsigned int buf_len;
> +       /* Pointer to storage for buffering read. */
> +       char *buf;
> +       /* End of the storage. */
> +       char *end;
> +       /* Currently accessed data pointer. */
> +       char *data;
> +       /* Set true on when the end of file on read error. */
> +       bool eof;
> +};
> +
> +static inline void io__init(struct io *io, int fd,
> +                           char *buf, unsigned int buf_len)
> +{
> +       io->fd = fd;
> +       io->buf_len = buf_len;
> +       io->buf = buf;
> +       io->end = buf;
> +       io->data = buf;
> +       io->eof = false;
> +}
> +
> +/* Reads one character from the "io" file with similar semantics to fgetc. */
> +static inline int io__get_char(struct io *io)
> +{
> +       char *ptr = io->data;
> +
> +       if (ptr == io->end) {
> +               ssize_t n = read(io->fd, io->buf, io->buf_len);
> +
> +               if (n <= 0) {
> +                       io->eof = true;
> +                       return -1;
> +               }
> +               ptr = &io->buf[0];
> +               io->end = &io->buf[n];
> +       }
> +       io->data = ptr + 1;
> +       return *ptr;
> +}
> +
> +/* Read a hexadecimal value with no 0x prefix into the out argument hex.
> + * Returns -1 on error or if nothing is read, otherwise returns the character
> + * after the hexadecimal value.
> + */
> +static inline int io__get_hex(struct io *io, __u64 *hex)
> +{
> +       bool first_read = true;
> +
> +       *hex = 0;
> +       while (true) {
> +               char ch = io__get_char(io);
> +

Maybe you can add this

    if (io->eof)
        return 0;

Please see below


> +               if (ch < 0)
> +                       return ch;
> +               if (ch >= '0' && ch <= '9')
> +                       *hex = (*hex << 4) | (ch - '0');
> +               else if (ch >= 'a' && ch <= 'f')
> +                       *hex = (*hex << 4) | (ch - 'a' + 10);
> +               else if (ch >= 'A' && ch <= 'F')
> +                       *hex = (*hex << 4) | (ch - 'A' + 10);
> +               else if (first_read)
> +                       return -1;
> +               else
> +                       return ch;
> +               first_read = false;
> +       }
> +}

What if a file contains hex digits at the end (without trailing spaces)?
I guess it'd see EOF and return -1, right?

And it'd better to be clear when it sees a big hex numbers -
it could have a comment that it'd simply discard upper bits
or return an error.

> +
> +/* Read a decimal value into the out argument dec.
> + * Returns -1 on error or if nothing is read, otherwise returns the character
> + * after the decimal value.
> + */
> +static inline int io__get_dec(struct io *io, __u64 *dec)
> +{
> +       bool first_read = true;
> +
> +       *dec = 0;
> +       while (true) {
> +               char ch = io__get_char(io);
> +
> +               if (ch < 0)
> +                       return ch;
> +               if (ch >= '0' && ch <= '9')
> +                       *dec = (*dec * 10) + ch - '0';
> +               else if (first_read)
> +                       return -1;
> +               else
> +                       return ch;
> +               first_read = false;
> +       }
> +}

Ditto.

Thanks
Namhyung


> +
> +#endif /* __API_IO__ */
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>
