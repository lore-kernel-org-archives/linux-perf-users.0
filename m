Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A5664D
	for <linux-perf-users@vger.kernel.org>; Mon, 27 May 2024 00:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716771383; cv=none; b=RMUVnZwrd5VTPVjhhHhrnM3xoQPaK0LqZN7Xq/0jMFfcl7kdGxzFHn827S3vReFgNiIX5Nlwyw55zavA15icVywih90ZIP/AIPIT+DefdW95ARHPf9fmWmSjsWXfZwmhwDRLlHrhLjTfWm4IReTIsu2Il9KEP2tAHtpuTJgVi+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716771383; c=relaxed/simple;
	bh=k1OktcaHh9YBzhdTXmOI60dcUYQhSEEv3IlU4wQEZ0U=;
	h=MIME-Version:Message-Id:Date:From:To:Subject:Content-Type; b=L3MRoJmai/2wIG7NPEO8DdGfFfH2QVZb3gyhPdQWtCJmA1P3j8+ZFvJoctJO9UTiBA59Ae059AjLNdt/8sWHYt969WvHmtM+6oHwjHolvyUd1lzkxFHrYUuGSYPCSPp1MGn0nqBIcw9Fr2GohU4VPTFoauOedim/svpHExzH7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuuzetsu.co.uk; spf=pass smtp.mailfrom=fuuzetsu.co.uk; dkim=pass (2048-bit key) header.d=fuuzetsu.co.uk header.i=@fuuzetsu.co.uk header.b=SIYKYAi0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWOv+nuO; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuuzetsu.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuuzetsu.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuuzetsu.co.uk header.i=@fuuzetsu.co.uk header.b="SIYKYAi0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWOv+nuO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1CB591800097
	for <linux-perf-users@vger.kernel.org>; Sun, 26 May 2024 20:56:21 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Sun, 26 May 2024 20:56:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fuuzetsu.co.uk;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1716771380; x=1716857780; bh=Bp
	sMNMX7N6IE+gOPbdrFjki3S5LLg7EtHQxIqJhhEpg=; b=SIYKYAi03rBbmAl0E/
	m8NMAb/LvDbcuxfoC97Mj93axSf7FyhR795IhN/xfC3bmVIdCeW5BhX32j7PGnQi
	TsFuV7g9h0uIPNvxYb3FXw1oUrrQDwU6hjn3wL2QXcWZoTBYZHSg+2KgMjerul50
	xCU9EQikB8MP1HCJhRck/RbLeoXaOITMgK2vB1yRDANrO+dfkxE8SyQX0VD0Gh96
	Kd+Fr5QVjSKiGaSkCAS/7hZC4891fpXVOuRfTESIe1Rg/iizYnnKwCW4ijJ++c0a
	pnuNDs/PYoyYeJ1QKlaBTf3tGEqRvrQNBJySXCp2BnuCTZFCzfuYJWZBUr+KxFJl
	2zDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716771380; x=1716857780; bh=BpsMNMX7N6IE+gOPbdrFjki3S5LL
	g7EtHQxIqJhhEpg=; b=hWOv+nuObNly6p683eIXPb8X4YIjlMcKbnlJGzgC85Q7
	qVpbXFLDWNAN1whLHruCmZA0sWcMkC12Iot5LQreRoUYyV+BGBlh8ZWBJYVTF/DD
	CjIRob16508kBa/5IT5SNTjBY1fPzHynwFpBwx6LDUcBcvGnuWOFmeJTZEsXbBlv
	oYXESLq5xL3c4PmRupFi0jS4Bgmi+G9WFnw39BggaPGieo/0KJXk641mJ3cupCN4
	FtTymJvRI4WWDOc7VcGWVcn8G0CDfidYSakBrkn9yFSbqr/zVKRjVgocpBGQB3Z8
	Eh9hiXxoBR5AmuIcSO/LtRW3AS3m7sAg1NXpzRpx9Q==
X-ME-Sender: <xms:NNpTZo0wHw3i_Z70vJWpHUtUqeP7lQ554ZqhSqIVezKE6BPCkTZyJQ>
    <xme:NNpTZjF22OudWukxOTmpAwCAjLFTllC6Eaima1tFfnCE5BY4AZZR8Z4Eb3xnJNIno
    ob3tQlkhyUfVJfc1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejfedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtgfesthhqre
    dtreerjeenucfhrhhomhepfdforghtvghushiiucfmohifrghltgiihihkfdcuoehfuhhu
    iigvthhsuhesfhhuuhiivghtshhurdgtohdruhhkqeenucggtffrrghtthgvrhhnpeeihf
    efleekveelleeiheelheehveeiffeiveetheefvefhgfdvueffieffjeejgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehfuhhuiigvthhsuh
    esfhhuuhiivghtshhurdgtohdruhhk
X-ME-Proxy: <xmx:NNpTZg6x5k_JNUp5dZ4NtS4HCH4GTAK9KVeJck0PYEA1WQbgOiIxqg>
    <xmx:NNpTZh1jF-oEGZkG-tXSAiMtIUPIZt9LdfIrEnX-qBMpqdC9vmPcLQ>
    <xmx:NNpTZrEFAXB-76x6sbqe9LacZU6j-f__09I0iBGKeObJckkWGhrOAg>
    <xmx:NNpTZq8On9kt0QcY8HjFpbIvpdK7Qry1RFRRzt-hfdxJaI4rrhJvtA>
    <xmx:NNpTZuOhBwbgQ6ZFOdIqT0dMADc9diCzGw4KS0Iosqw4CgOCVUgFDdCN>
Feedback-ID: ia5d440cb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 6DF25272007C; Sun, 26 May 2024 20:56:20 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-480-g515a2f54a-fm-20240515.001-g515a2f54
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
Date: Mon, 27 May 2024 09:56:00 +0900
From: "Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Why does libtracevent pkg-config detection wipe PKG_CONFIG_PATH?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

To build recent perf, I'm having to apply the below patch.

```diff
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 7f1e016a9253..b70fef12a977 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1181,7 +1181,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
     CFLAGS +=3D -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
     LDFLAGS +=3D $(LIBTRACEEVENT_LDFLAGS)
     EXTLIBS +=3D ${TRACEEVENTLIBS}
-    LIBTRACEEVENT_VERSION :=3D $(shell PKG_CONFIG_PATH=3D$(LIBTRACEEVEN=
T_DIR) $(PKG_CONFIG) --modversion libtraceevent)
+    LIBTRACEEVENT_VERSION :=3D $(shell $(PKG_CONFIG) --modversion libtr=
aceevent)
     LIBTRACEEVENT_VERSION_1 :=3D $(word 1, $(subst ., ,$(LIBTRACEEVENT_=
VERSION)))
     LIBTRACEEVENT_VERSION_2 :=3D $(word 2, $(subst ., ,$(LIBTRACEEVENT_=
VERSION)))
     LIBTRACEEVENT_VERSION_3 :=3D $(word 3, $(subst ., ,$(LIBTRACEEVENT_=
VERSION)))
```

I don't understand why `PKG_CONFIG_PATH` is overwritten this way. `grep`=
ing for PKG_CONFIG_PATH reveals that this isn't done anywhere else in th=
e kernel tree. All other uses of `$(PKG_CONFIG)` in the file simply invo=
ke the tool.

Of course, I do actually have `libtraceevent.pc` available, it's just th=
at `LIBTRACEVENT_DIR` is empty which stops it from finding it.

```
[shana@aya:~/programming/linux/tools/perf]$ pkg-config --modversion libt=
raceevent
1.8.2
```

If I do not apply the patch, I'm getting the below errors during build.

I'm not sure how others are getting it to build, maybe I'm doing somethi=
ng wrong? Please let me know. If the diff is fine, it'd be great if anyo=
ne could apply it.

Thanks!

```
Perhaps you should add the directory containing `libtraceevent.pc'
to the PKG_CONFIG_PATH environment variable
No package 'libtraceevent' found
expr: syntax error: unexpected argument =E2=80=98255=E2=80=99

Auto-detecting system features:
...                                   dwarf: [ on  ]
...                      dwarf_getlocations: [ on  ]
...                                   glibc: [ on  ]
...                                  libbfd: [ on  ]
...                          libbfd-buildid: [ on  ]
...                                  libcap: [ on  ]
...                                  libelf: [ on  ]
...                                 libnuma: [ on  ]
...                  numa_num_possible_cpus: [ on  ]
...                                 libperl: [ on  ]
...                               libpython: [ on  ]
...                               libcrypto: [ on  ]
...                               libunwind: [ on  ]
...                      libdw-dwarf-unwind: [ on  ]
...                             libcapstone: [ OFF ]
...                                    zlib: [ on  ]
...                                    lzma: [ on  ]
...                               get_cpuid: [ on  ]
...                                     bpf: [ on  ]
...                                  libaio: [ on  ]
...                                 libzstd: [ on  ]

  INSTALL libsubcmd_headers
  PERF_VERSION =3D 6.10.rc1.g1613e604df0c
  GEN     perf-archive
  GEN     perf-iostat
  INSTALL libsymbol_headers
  INSTALL libapi_headers
  INSTALL libperf_headers
  INSTALL libbpf_headers
  TEST    pmu-events/metric_test.log
  CC      builtin-bench.o
  CC      builtin-annotate.o
  CC      builtin-config.o
  CC      builtin-diff.o
  CC      builtin-evlist.o
  CC      builtin-ftrace.o
  CC      builtin-help.o
  CC      builtin-buildid-list.o
  CC      builtin-buildid-cache.o
  CC      builtin-kallsyms.o
  CC      builtin-list.o
  GEN     pmu-events/pmu-events.c
In file included from util/session.h:5,
                 from builtin-buildid-list.c:17:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
In file included from util/session.h:5,
                 from builtin-evlist.c:15:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
In file included from util/session.h:5,
                 from builtin-buildid-cache.c:24:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
  CC      builtin-record.o
In file included from util/session.h:5,
                 from builtin-diff.c:15:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
  CC      builtin-report.o
  CC      builtin-stat.o
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-buildid-list.o] Error 1
make[3]: *** Waiting for unfinished jobs....
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-evlist.o] Error 1
In file included from util/session.h:5,
                 from builtin-annotate.c:32:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-buildid-cache.o] Error 1
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-annotate.o] Error 1
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-diff.o] Error 1
In file included from util/session.h:5,
                 from builtin-record.c:27:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
In file included from util/session.h:5,
                 from builtin-stat.c:60:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
In file included from util/session.h:5,
                 from builtin-report.c:35:
util/trace-event.h:152:62: error: operator '&&' has no right operand
  152 | #if defined(LIBTRACEEVENT_VERSION) &&  LIBTRACEEVENT_VERSION >=3D=
 MAKE_LIBTRACEEVENT_VERSION(1, 5, 0)
      |                                                              ^~
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-record.o] Error 1
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-report.o] Error 1
make[3]: *** [/home/shana/programming/linux/tools/build/Makefile.build:1=
05: builtin-stat.o] Error 1
make[2]: *** [Makefile.perf:727: perf-in.o] Error 2
make[2]: *** Waiting for unfinished jobs....
  CC      pmu-events/pmu-events.o
  LD      pmu-events/pmu-events-in.o
make[1]: *** [Makefile.perf:264: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
perf version 6.10.rc1.g5f00d82dec63

```

--
Mateusz K.
