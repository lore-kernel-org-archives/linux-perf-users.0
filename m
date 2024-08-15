Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F153E24
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 18:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723746511; cv=none; b=CdLyrH1CHch6pPZPgqzQBKjNBw5hEMd3VLdslWWCMCrFo0PbmOk+9bZ2gfI8K/Iz3FivcvXXldX57g0ceMVdQidmMuC2JGXvdj6HfAdpV4kPcr2hLGdKO75+OHAiqIgfUgUnMUgugaaEiCv5AP0zs7IdPyt9yJlHxlQU6j5ImCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723746511; c=relaxed/simple;
	bh=gj7/pYjjGycnRZMYqoRqmPQjLnXoTeHesHwyhYpp08M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY4ayP+WQIci4B5bcKNxHPbJuyPUPltoq3Po4Jv8zhFHvF63goEFZBuAAMIzHIWU0Q1PrGWKTFnsOQ7KUtcAl31k6JQOw2CGKbBimA6F0CCFGTdWP+L81iDz75/4oTE+vtv4GdSGoymhieW7ULuz1SbiuEWG6MTuuQlSXPZRwsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3683zELg; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3683zELg"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-39b167a6f3bso11545ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 15 Aug 2024 11:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723746509; x=1724351309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgHoKUTNqKykjVvaglc3taV0yZ6bQmeK4Efc0CRYWe8=;
        b=3683zELglWTQsF7ZwIIKzOdDFKs/7BrGnlmCwuY7worMusnAW1cFslXBtQVawpry7r
         MhmUUDpIOYYpA20JW3iBHYKaRY3mbEPrbBZJrpB/uZXGtZGhapmFlFl3ZwzIQWJGzMe0
         Vu0ePR8esHpJKPawdD1uPtcg8G0mskmCwK7tBurfcWhtWeVRDaDUoHlPyZVyXc2IPbK4
         O3mi2wI3GVzXhHcB4UzzuW4Cm5td2s/+zlOqiMIZk1hN+cq+zYskqECLUCbx6107bL34
         qUkVG4YmieuQ0cuBhgA9KhgbCo87VwNOpPEtZgHjHa+85hl1Yz7Vikd8PsImcRRqwmTx
         BWtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723746509; x=1724351309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HgHoKUTNqKykjVvaglc3taV0yZ6bQmeK4Efc0CRYWe8=;
        b=d/SfixXD87oXv6GN/9BHzUk+8t4j4Hz7CD+lkfqg0vQnRdp6qoRJ5SwHhAhvCOTsnf
         Zh9BLqabEtv44E7vG6cwV814l/LFxlXHIXKfOKoYJM9iZBYZJ2TTD3yffXZhZykNEoU7
         pvkse7r8vK0FW+S3HaX4rybXNU3RvE/A8/h7k/RubDPXEZe0ZJ9UphPyJ8g69RA8ARx/
         9gHe+DlpZQKx/5PanmzPdHk26hOAEFKQXU/ieq+ThfgyUmFeeFqInYO5tsex0EfJHqqv
         JISYOjgS6TTyMXdUNw5hpn55WKBOMgCwf1oM+kX8Dx6Cf7Sbod88pWG4jR8UAhThvb05
         ZF3g==
X-Forwarded-Encrypted: i=1; AJvYcCXa0Lmk+pV30G5Cv7H16WjVFEgwt5Q783U4471zhCcP317rPSA7QSBeJ8KxMkHoMbLMbeHRYvdDWCGIC7iESB0Dbs6HrPT79+Sm4JlAInvPeg==
X-Gm-Message-State: AOJu0Yzzq9hRVoqkS/yvliU02R5Dgi/vBSjOCiuRbx3O33310Z34xKud
	L4GmKWlkgv1HiIL0vVKQC3KJe/E/hQSA8F2Lr3uqG91nxCxTg9uWy5U6gNUUsiaLT3h82c08IaY
	4Zv6TIOXrXTI4Oli/ZiYURx/zZdXtddcI1q+5RQIfvs6Gq5XCZFyf
X-Google-Smtp-Source: AGHT+IH7LVkqKvI8Tnzk1pZa7FTYvAPfPqYPg9+BgIYuCR1j2DfYKhAkx7JiP/IVL6x/agoj5kq0uxowcwzwydpuC/k=
X-Received: by 2002:a05:6e02:1d0f:b0:39d:2497:6207 with SMTP id
 e9e14a558f8ab-39d27bc3cf3mr67935ab.5.1723746509211; Thu, 15 Aug 2024 11:28:29
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815013626.935097-1-howardchu95@gmail.com> <20240815013626.935097-2-howardchu95@gmail.com>
In-Reply-To: <20240815013626.935097-2-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 15 Aug 2024 11:28:17 -0700
Message-ID: <CAP-5=fXCt4axmdjqDZXZzjW-gZK_KZ8R--OTR-M1sZYxZ94k5A@mail.gmail.com>
Subject: Re: [PATCH v2 01/10] perf trace: Fix perf trace -p <PID>
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, jolsa@kernel.org, 
	kan.liang@linux.intel.com, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:36=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> perf trace -p <PID> work on a syscall that is unaugmented, but doesn't
> work on a syscall that's augmented (when it calls perf_event_output() in
> BPF).
>
> Let's take open() as an example. open() is augmented in perf trace.
>
> Before:
> ```
> perf $ perf trace -e open -p 3792392
>          ? (         ):  ... [continued]: open())                        =
                     =3D -1 ENOENT (No such file or directory)
>          ? (         ):  ... [continued]: open())                        =
                     =3D -1 ENOENT (No such file or directory)
> ```
>
> We can see there's no output.
>
> After:
> ```
> perf $ perf trace -e open -p 3792392
>      0.000 ( 0.123 ms): a.out/3792392 open(filename: "DINGZHEN", flags: W=
RONLY)                             =3D -1 ENOENT (No such file or directory=
)
>   1000.398 ( 0.116 ms): a.out/3792392 open(filename: "DINGZHEN", flags: W=
RONLY)                             =3D -1 ENOENT (No such file or directory=
)
> ```
>
> Reason:
>
> bpf_perf_event_output() will fail when you specify a pid in perf trace (E=
OPNOTSUPP).
>
> When using perf trace -p 114, before perf_event_open(), we'll have PID
> =3D 114, and CPU =3D -1.
>
> This is bad for bpf-output event, because the ring buffer won't accept
> output from BPF's perf_event_output(), making it fail. I'm still trying
> to find out why.
>
> If we open bpf-output for every cpu, instead of setting it to -1, like
> this:
> PID =3D <PID>, CPU =3D 0
> PID =3D <PID>, CPU =3D 1
> PID =3D <PID>, CPU =3D 2
> PID =3D <PID>, CPU =3D 3
> ...
>
> Everything works.
>
> You can test it with this script:
> ```
>  #include <unistd.h>
>  #include <sys/syscall.h>
>
> int main()
> {
>         int i1 =3D 1, i2 =3D 2, i3 =3D 3, i4 =3D 4;
>         char s1[] =3D "DINGZHEN", s2[] =3D "XUEBAO";
>
>         while (1) {
>                 syscall(SYS_open, s1, i1, i2);
>                 sleep(1);
>         }
>
>         return 0;
> }
> ```
>
> save, compile
> ```
> gcc open.c
> ```
>
> perf trace
> ```
> perf trace -e open <path-to-the-executable>
> ```
>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/evlist.c | 14 +++++++++++++-
>  tools/perf/util/evlist.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
> index c0379fa1ccfe..f14b7e6ff1dc 100644
> --- a/tools/perf/util/evlist.c
> +++ b/tools/perf/util/evlist.c
> @@ -1067,7 +1067,7 @@ int evlist__create_maps(struct evlist *evlist, stru=
ct target *target)
>         if (!threads)
>                 return -1;
>
> -       if (target__uses_dummy_map(target))
> +       if (target__uses_dummy_map(target) && !evlist__has_bpf_output(evl=
ist))

I'm wondering if there should be a comment above this, something like:

Do we need the "any"/-1 CPU value or do we need to open an event on
all target CPUs (the default NULL implies all online CPUs). The dummy
map indicates that we need sideband perf record events in order to
symbolize samples. The mmap-ed ring buffers need CPUs. Similarly BPF
output events need ring buffers.

I'm not 100% on the ring buffer perf_event_open restrictions, and the
man page doesn't cover it, my knowledge is implied from failures and
seeing what the tool does.

Thanks,
Ian


>                 cpus =3D perf_cpu_map__new_any_cpu();
>         else
>                 cpus =3D perf_cpu_map__new(target->cpu_list);
> @@ -2627,3 +2627,15 @@ void evlist__uniquify_name(struct evlist *evlist)
>                 }
>         }
>  }
> +
> +bool evlist__has_bpf_output(struct evlist *evlist)
> +{
> +       struct evsel *evsel;
> +
> +       evlist__for_each_entry(evlist, evsel) {
> +               if (evsel__is_bpf_output(evsel))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
> index b46f1a320783..bcc1c6984bb5 100644
> --- a/tools/perf/util/evlist.h
> +++ b/tools/perf/util/evlist.h
> @@ -447,5 +447,6 @@ int evlist__scnprintf_evsels(struct evlist *evlist, s=
ize_t size, char *bf);
>  void evlist__check_mem_load_aux(struct evlist *evlist);
>  void evlist__warn_user_requested_cpus(struct evlist *evlist, const char =
*cpu_list);
>  void evlist__uniquify_name(struct evlist *evlist);
> +bool evlist__has_bpf_output(struct evlist *evlist);
>
>  #endif /* __PERF_EVLIST_H */
> --
> 2.45.2
>
