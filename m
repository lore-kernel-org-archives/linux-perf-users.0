Received: from mail.kdab.com (mail.kdab.com [176.9.126.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20418131182
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 11:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.126.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717501768; cv=none; b=k+u5MYNyxBRLb4F660YamH2sL/30mdlPUaORbpo74pXzvlr1agXYH4d0eRa01K+lNazLR+WefzxD8saVIZMH7xchdKoNNF/cxNQfNMkKdJ43fYdPGSexh1WaGSXtI2Uw3vLEWPHH8N3RpBp+2z++JYniTBzk7PvyjRUw/wJrakU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717501768; c=relaxed/simple;
	bh=7H8mNYTC3+mfiuZ53ogV6WWWr9ylhfXeMyB/iqLtqLA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hGirH1pzYfPH/ckqV3N0jEBT4QJotb/guAb0PLe14mcU4IbDjrbWtN+VT2yhQmnekETOXqwTCE+2xGD0Er6QE/QS1H/Ah4gg0p3ofh4p/IXw9ocY3k6qZq1S6+aAqOXtB4LWkCr13hSf31tbHi13eO1b+Uo/4EeG8n7SWLpCm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com; spf=pass smtp.mailfrom=kdab.com; dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b=B3yryFP+; arc=none smtp.client-ip=176.9.126.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kdab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kdab.com header.i=@kdab.com header.b="B3yryFP+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kdab.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :organization:message-id:date:date:subject:subject:from:from; s=
 dkim; t=1717501220; x=1718365221; bh=kfv6UI3vJYFS2EFMU0/m6LRXman
 jBnAsXmZr3iFfG54=; b=B3yryFP+kShhJq7qP+Hs/MLkC2l4H7xM/hRZhWV3nvY
 S5WU52xsahveiZ4TkrG1W8jDHDZvwgnMOO8EBirpzZ0a3+VVTslX9jSS6lM+aUR2
 B4+IsUkxEsB3ecsLVroYDqeO+/p2QlWU+psmODkStR/G1UxbLaVLBvJ+DrTst9qo
 =
X-Virus-Scanned: amavisd-new at kdab.com
From: Milian Wolff <milian.wolff@kdab.com>
To: linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kenel.org>
Subject: perf FTBFS due to -Werror with gcc 14.1.1
Date: Tue, 04 Jun 2024 13:40:19 +0200
Message-ID: <11178410.LHx4AX4RY1@milian-workstation>
Organization: KDAB
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hey all,

I cannot build the acme perf/core branch on Arch anymore with gcc 14.1.1 an=
d=20
Linux 6.9.3 due to multiple -Werror issues. Is this known and if so is anyo=
ne=20
working on it? Otherwise we can try to get this fixed ourselves and upstrea=
m=20
the patches then:

```
  CC      builtin-record.o
  CC      builtin-top.o
  CC      util/metricgroup.o
  CC      util/hist.o
  CC      util/synthetic-events.o
  CC      util/bpf-loader.o
tests/bpf.c: In function =E2=80=98epoll_pwait_loop=E2=80=99:
tests/bpf.c:36:17: error: argument 2 null where non-null expected [-
Werror=3Dnonnull]
   36 |                 epoll_pwait(-(i + 1), NULL, 0, 0, NULL);
      |                 ^~~~~~~~~~~
In file included from tests/bpf.c:5:
/usr/include/sys/epoll.h:134:12: note: in a call to function =E2=80=98epoll=
_pwait=E2=80=99=20
declared =E2=80=98nonnull=E2=80=99
  134 | extern int epoll_pwait (int __epfd, struct epoll_event *__events,
      |            ^~~~~~~~~~~
cc1: all warnings being treated as errors
make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97=
:=20
tests/bpf.o] Error 1
make[3]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:14=
0:=20
tests] Error 2
make[3]: *** Waiting for unfinished jobs....
util/metricgroup.c: In function =E2=80=98setup_metric_events=E2=80=99:
util/metricgroup.c:289:39: error: =E2=80=98calloc=E2=80=99 sizes specified =
with =E2=80=98sizeof=E2=80=99 in=20
the earlier argument and not in the later argument [-Werror=3Dcalloc-transp=
osed-
args]
  289 |         metric_events =3D calloc(sizeof(void *), ids_size + 1);
      |                                       ^~~~
util/metricgroup.c:289:39: note: earlier argument should specify number of=
=20
elements, later size of each element
cc1: all warnings being treated as errors
make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97=
:=20
util/metricgroup.o] Error 1
make[4]: *** Waiting for unfinished jobs....
builtin-top.c: In function =E2=80=98prompt_integer=E2=80=99:
builtin-top.c:360:21: error: allocation of insufficient size =E2=80=980=E2=
=80=99 for type=20
=E2=80=98char=E2=80=99 with size =E2=80=981=E2=80=99 [-Werror=3Dalloc-size]
  360 |         char *buf =3D malloc(0), *p;
      |                     ^~~~~~
cc1: all warnings being treated as errors
make[3]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97=
:=20
builtin-top.o] Error 1
util/bpf-loader.c: In function =E2=80=98config_bpf_program=E2=80=99:
util/bpf-loader.c:551:29: error: =E2=80=98calloc=E2=80=99 sizes specified w=
ith =E2=80=98sizeof=E2=80=99 in the=20
earlier argument and not in the later argument [-Werror=3Dcalloc-transposed-
args]
  551 |         priv =3D calloc(sizeof(*priv), 1);
      |                             ^
util/bpf-loader.c:551:29: note: earlier argument should specify number of=20
elements, later size of each element
cc1: all warnings being treated as errors
make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97=
:=20
util/bpf-loader.o] Error 1
util/synthetic-events.c: In function =E2=80=98perf_event__synthesize_thread=
s=E2=80=99:
util/synthetic-events.c:1042:44: error: =E2=80=98calloc=E2=80=99 sizes spec=
ified with =E2=80=98sizeof=E2=80=99=20
in the earlier argument and not in the later argument [-Werror=3Dcalloc-
transposed-args]
 1042 |         synthesize_threads =3D calloc(sizeof(pthread_t), thread_nr);
      |                                            ^~~~~~~~~
util/synthetic-events.c:1042:44: note: earlier argument should specify numb=
er=20
of elements, later size of each element
util/synthetic-events.c:1046:29: error: =E2=80=98calloc=E2=80=99 sizes spec=
ified with =E2=80=98sizeof=E2=80=99=20
in the earlier argument and not in the later argument [-Werror=3Dcalloc-
transposed-args]
 1046 |         args =3D calloc(sizeof(*args), thread_nr);
      |                             ^
util/synthetic-events.c:1046:29: note: earlier argument should specify numb=
er=20
of elements, later size of each element
cc1: all warnings being treated as errors
make[4]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97=
:=20
util/synthetic-events.o] Error 1
builtin-record.c: In function =E2=80=98cmd_record=E2=80=99:
builtin-record.c:4091:62: error: =E2=80=98calloc=E2=80=99 sizes specified w=
ith =E2=80=98sizeof=E2=80=99 in the=20
earlier argument and not in the later argument [-Werror=3Dcalloc-transposed-
args]
 4091 |                 rec->switch_output.filenames =3D calloc(sizeof(char=
 *),
      |                                                              ^~~~
builtin-record.c:4091:62: note: earlier argument should specify number of=20
elements, later size of each element
cc1: all warnings being treated as errors
make[3]: *** [/home/milian/projects/src/linux/tools/build/Makefile.build:97=
:=20
builtin-record.o] Error 1
util/hist.c: In function =E2=80=98hist_entry__init=E2=80=99:
util/hist.c:494:49: error: =E2=80=98calloc=E2=80=99 sizes specified with =
=E2=80=98sizeof=E2=80=99 in the=20
earlier argument and not in the later argument [-Werror=3Dcalloc-transposed-
args]
  494 |                 he->res_samples =3D calloc(sizeof(struct res_sample=
),
      |                                                 ^~~~~~
```

Thanks

=2D-=20
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt, C++ and OpenGL Experts

