Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABC2E57D
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jul 2024 19:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720295742; cv=none; b=nJOYaQNQhXlLvkPqVWxdslVCEdlnhwULEBhSZ9rQPDo2NtLdfcN66+PODMTz697KctLd6ImtA5DjsMxF7s9mIdS3UVkyNsAALNARglboTQk2mGHzUCsIMVIo8gKyy5K4ASIgbuPJyM9XuEIlQbXli885XK7gaqB4XUSczT+fB5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720295742; c=relaxed/simple;
	bh=qPZCVJsy6oiiEwephcs81EGcIGqRR/UsaKmEJsRrK1Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=GNhv+jywgS6RXXzMXRChroB1db8mcHi/cMXdntsxcUjOyE3w1dtUb3wwpiWekaqvMh/zVpb4dGUayzlUNgiesXaNN1xY9DihkswL4g3YGublFHCsFih8GKpTNq6FoYiwZMPWDhnzP8e/BS8JMNPAacrE6eNl6tQPOucUWJAHRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EETMNoL/; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EETMNoL/"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-4f2e2795350so1796893e0c.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jul 2024 12:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1720295739; x=1720900539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xsdNu7eYO6WjWWMrIum1S9kQPi9l9KATlOWX77pOhQg=;
        b=EETMNoL/ETAbQCCq1F6Dhvh2e31RSjMrEQ0K894k4s+IKkDxqUcQYbJbech1a2gRJB
         2cjhUSBiAC7//FZ55vtyZI7nW1lR0QUTpQKqIHTqZ3sJZ28uzT7dFaJsFCAJlQ2UgskX
         euJjAVq9G99jKFh/Vulv8S38o4KtWEPtqCzms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720295739; x=1720900539;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsdNu7eYO6WjWWMrIum1S9kQPi9l9KATlOWX77pOhQg=;
        b=XnMXl+LMzy1ZKO+cVkdpfABP1KZn76y5aSx5jUOARAldrBrCLRystCFTXhIH4+h2vD
         6+lwRYAD3UYGlAnLDveyfn7ZOFuoUyrnlohsT886A6aTrzt5fYZbzwlKR/aYJcEt17C+
         MpndcNOMrXEr56rLDNtLG36tm/EUhquMmEubVzOjVzh88BCGK7KyRIHaSOORZySB+T2n
         E1DxPt76UUkae62BqvZ8XuVex/EEZasE9PUaRgOwVqzK9yncvI14m9/Je3UFkfmyjlzm
         xa8xZpvuRCHzj05TR9tS9vNuuORuLoo1B1V+O4UOzZ+16PC/+cIcil3PH3QUDcE3PA04
         5Fjg==
X-Gm-Message-State: AOJu0YxFyxYPVTmHT6lKtJTbe6jY5jpfeZH5YSw264U5pKIsbrjP23gN
	Ptb+m3G35hmpPbilOqCqiBKuwk5lTUssTlCLv3NBSHUjRkLVhiRVR+czCwSbexfeOKc+cFtl+gQ
	ff0qmOA==
X-Google-Smtp-Source: AGHT+IGLSaqK2S9GUb7dyrc/W22DE3hpbidlrxIySI8yBRtk7L7VFLzJBbic0QUSxbp5xt2RwodDVw==
X-Received: by 2002:a1f:f445:0:b0:4eb:1d6b:7a6d with SMTP id 71dfb90a1353d-4f2f6234386mr4344161e0c.7.1720295738831;
        Sat, 06 Jul 2024 12:55:38 -0700 (PDT)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f2f37f4881sm754061e0c.29.2024.07.06.12.55.38
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jul 2024 12:55:38 -0700 (PDT)
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-80fc4fe7a8eso1359315241.1
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jul 2024 12:55:38 -0700 (PDT)
X-Received: by 2002:a05:6102:116d:b0:48f:3b56:a184 with SMTP id
 ada2fe7eead31-48fef1c6a0dmr5350050137.5.1720295737765; Sat, 06 Jul 2024
 12:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 6 Jul 2024 12:55:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
Message-ID: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
Subject: Performance of 'perf'
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

So I tend to try to do things like this:

    perf record -a -e cpu-cycles:ppk make -j199 > ../makes

where that 'make' is basically a full allmodconfig build.

It turns out that 'perf' writing out the data is SLOWER THAN THE BUILD.

And no, it's not because I have a slow disk, and the writeout is slow.
It's because apparently for every single record, perf does something
like this:

  newfstatat(AT_FDCWD, "/proc/self/ns/mnt", {st_mode=S_IFREG|0444,
st_size=0, ...}, 0) = 0
  newfstatat(AT_FDCWD, "/proc/258055/ns/mnt", 0xffffe0c65f18, 0) = -1
ENOENT (No such file or directory)

and it's literally using 100% CPU for many many minutes because this
is all serial and stupid.

It's not _only_ doing those fstat() calls (it's glibc that then turns
stat calls into newfstatat(), because glibc is incompetent and doing
completely stupdi things, slowing things down even further). A strace
snippet tends to be a practically endless loop of

  fcntl(391, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
  newfstatat(391, "", {st_mode=S_IFREG|0755, st_size=1076528, ...},
AT_EMPTY_PATH) = 0
  pread64(391, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\2\0\267\0\1\0\0\0\200wC\0\0\0\0\0"...,
64, 0) = 64
  newfstatat(AT_FDCWD, "/proc/self/ns/mnt", {st_mode=S_IFREG|0444,
st_size=0, ...}, 0) = 0
  newfstatat(AT_FDCWD, "/proc/307523/ns/mnt", 0xffffe0c65f18, 0) = -1
ENOENT (No such file or directory)
  newfstatat(AT_FDCWD, "/proc/self/ns/mnt", {st_mode=S_IFREG|0444,
st_size=0, ...}, 0) = 0
  newfstatat(AT_FDCWD, "/proc/307021/ns/mnt", 0xffffe0c65ee8, 0) = -1
ENOENT (No such file or directory)
  fcntl(393, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
  newfstatat(393, "", {st_mode=S_IFREG|0755, st_size=203552, ...},
AT_EMPTY_PATH) = 0
  pread64(393, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\2\0\267\0\1\0\0\0\300\6A\0\0\0\0\0"...,
64, 0) = 64
  newfstatat(AT_FDCWD, "/proc/self/ns/mnt", {st_mode=S_IFREG|0444,
st_size=0, ...}, 0) = 0
  newfstatat(AT_FDCWD, "/proc/307524/ns/mnt", 0xffffe0c65f18, 0) = -1
ENOENT (No such file or directory)
  fcntl(391, F_GETFD)                     = 0x1 (flags FD_CLOEXEC)
  ...

and those stat calls seem to come from nsinfo__init(). Which despite
the name is not exactly an "init" function, it's called by
nsinfo__new(), and all of this seems to happen *after* the profiling
has already finished, ie I see it after 'perf record' has written out

   [ perf record: Woken up 9675 times to write data ]

and then 'perf record' will just halt for something like half an hour.

I'm sure there's tons of other things going on in between the system
calls, but I have no idea what. Doing ltrace() shows it doing an
endless stream of "strcmp()", and attaching to it with gdb says that
it's in

#14 0x0000fffebf319d08 in qsort_r () from /lib64/libc.so.6
#15 0x0000000000534720 in comm_strs.findnew.part ()
#16 0x0000000000534844 in comm.new ()
#17 0x0000000000534e14 in thread.new ()
#18 0x0000000000536234 in threads.findnew ()
#19 0x000000000052092c in __machine__findnew_thread ()
#20 0x0000000000524404 in machine.process_fork_event ()
#21 0x000000000052da44 in perf_session.deliver_event ()
#22 0x0000000000532750 in __ordered_events__flush ()
#23 0x000000000052c98c in perf_session.process_user_event ()
#24 0x000000000052dff8 in reader.read_event ()
#25 0x000000000052f784 in perf_session.process_events ()
#26 0x0000000000422470 in record.finish_output.constprop ()
#27 0x00000000004256b8 in __cmd_record.constprop.0 ()
#28 0x0000000000427b54 in cmd_record ()
#29 0x00000000004c492c in run_builtin ()
#30 0x00000000004c4c10 in handle_internal_command ()

which hopefully gives some perf person an idea of what is going on.

Anyway, it's slow. As in HORRENDOUSLY slow. There's something
seriously wrong here.

And yes, it might be made worse by this being an arm64 profile, and
maybe this process_events loop is faster with different kinds of
events and this is some worst-case loop.

I don't know the perf tooling code AT ALL. Please, somebody who does
know it, can you take a look? Because this literally makes profiling
of certain loads practically impossible.

                     Linus
