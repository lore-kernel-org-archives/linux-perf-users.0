Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02FB7;
	Tue, 12 Dec 2023 17:34:01 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ceb93fb381so4657121b3a.0;
        Tue, 12 Dec 2023 17:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702431241; x=1703036041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL8WQ6XQifHuAl5/6bibXSmjCD6Q0OYVm2RrMW20160=;
        b=Dj9xxVLGyJ/Ein3/G6+yxCuYRH9f8Koi2yNVSXQQDby3iEYadeA4hwiQmBs3N59/M4
         VLiiJ9TKhqKdTLLyZkQPXxCsg+XTDobHkBtuBZ6LNjLJVOMYDCEsI5hwsFgZvtpVBTvt
         prcTFRRDdHufRGOM8fQqBhMEv7B2AOMu5yE99ysBT6CcJkax2Ylc4pMHH6cZyLup7BkB
         vSXpSEUvTFljQTOBUuZU8L+53XM9xup4245/ZkW71QeEoyfL4Lr4aKf9/jBEHsYkKEm+
         cXyHEUfpuwOf9xeYPpwTTbtKeH/w7bJBqoRRUUtCBT8rTy8kixAV/9jBv76ZOSoxhAng
         7Y/A==
X-Gm-Message-State: AOJu0YzyZJwP70yxyG8YSAo19PqpbsJt2QnxnPK7jBAnuJEi8TdBfu/i
	nksalzl/QERBx6Os+AGmVSItm6ZFq+HPFEO+m3I=
X-Google-Smtp-Source: AGHT+IEhmNLmhGxrtCgZOy7pCkCFeOrqo6QXJpKEFM9cw7GkYQJG+xBQkr1qR4/tejyjGGUgs3t5wUdovowNAca85qM=
X-Received: by 2002:a05:6a00:2301:b0:6c3:4bf2:7486 with SMTP id
 h1-20020a056a00230100b006c34bf27486mr9484517pfh.7.1702431240694; Tue, 12 Dec
 2023 17:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207050433.1426834-1-irogers@google.com> <20231207050433.1426834-3-irogers@google.com>
 <CAM9d7cgRZp3PieHDvsdFXG+pNG0TTKoAaH6ZxC1XAnrvRLE1Pw@mail.gmail.com> <CAP-5=fXuZCkbAU0wakLyu3svpvUjzugAOjZzeGg9jZyJRXpoDA@mail.gmail.com>
In-Reply-To: <CAP-5=fXuZCkbAU0wakLyu3svpvUjzugAOjZzeGg9jZyJRXpoDA@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 12 Dec 2023 17:33:49 -0800
Message-ID: <CAM9d7cjcuz1ifeHUC=kqNsZVHn_jUsM-XWQRoXD1MVzRcoZ-kQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] tools lib api: Add io_dir an allocation free
 readdir alternative
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Quentin Monnet <quentin@isovalent.com>, 
	Fangrui Song <maskray@google.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Yanteng Si <siyanteng@loongson.cn>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, James Clark <james.clark@arm.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 3:54=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Mon, Dec 11, 2023 at 3:25=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > On Wed, Dec 6, 2023 at 9:04=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> > >
> > > glibc's opendir allocates a minimum of 32kb, when called recursively
> > > for a directory tree the memory consumption can add up - nearly 300kb
> > > during perf start-up when processing modules. Add a stack allocated
> > > variant of readdir sized a little more than 1kb.
> > >
> > > As getdents64 may be missing from libc, add support using syscall.
> >
> > Unfortunately my alpine build has:
> >
> > In file included from util/machine.c:2:
> > /build/libapi/include/api/io_dir.h:17:23: error: conflicting types for
> > 'getdents'; have 'ssize_t(int,  void *, size_t)' {aka 'long int(int,
> > void *, long unsigned int)'}
> >    17 | static inline ssize_t getdents64(int fd, void *dirp, size_t cou=
nt)
> >       |                       ^~~~~~~~~~
> > /usr/include/dirent.h:52:5: note: previous declaration of 'getdents'
> > with type 'int(int,  struct dirent *, size_t)' {aka 'int(int,  struct
> > dirent *, long unsigned int)'}
> >    52 | int getdents(int, struct dirent *, size_t);
> >       |     ^~~~~~~~
>
> Presumably there is a #define getdents64 getdents .. Could we stop
> caring about this version of Alpine linux?

Right, there's a #define:

https://git.musl-libc.org/cgit/musl/tree/include/dirent.h#n68

But I'm not sure ignoring Alpine linux is a good idea.
Maybe we can add a #undef right before?

Thanks,
Namhyung
