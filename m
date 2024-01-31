Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D3363
	for <linux-perf-users@vger.kernel.org>; Wed, 31 Jan 2024 00:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706661298; cv=none; b=BzVhVEO0tyMHI9c4CTiNS5Fb3dyyeOdl/vNiO2b6RXUBCnH9Z4FGSWXENP1PDrchNCIxnHeNXqQCBnWJSkna2qH4lG6YEzNzKxPCVLyyUU5QzAsv6DHdj+MCXioe+U7FM5DeCv/byV7rqMY60zpbnwejTQHMBfn/pFxdvO6SNv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706661298; c=relaxed/simple;
	bh=1sR192g6+eg9hY11fMrgWhUWDUVGPYhKqj80/XkdDaU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=uCm8JvLTMqSrFGN/H98Nm0DULKunidq7Z8G95/wdpuynyot0IOjxFXQWi/qdQCetPxXEcSS4fhlFci2uU6PLeORSkXcHozk6ZQFh6oJZ/n8FfVVV5gr1fHQE/M4ZqZK8Sxa0ZX2zA26s5s7FbEHMXVJOoASjsDViJ1ihLgMpQPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu-edu.20230601.gappssmtp.com header.i=@asu-edu.20230601.gappssmtp.com header.b=27SjUVy+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu-edu.20230601.gappssmtp.com header.i=@asu-edu.20230601.gappssmtp.com header.b="27SjUVy+"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-295d86ba26eso198226a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 30 Jan 2024 16:34:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu-edu.20230601.gappssmtp.com; s=20230601; t=1706661295; x=1707266095; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jp6KKW0ZIX0DZ+zwbJajmfE3NHhPWe/Ixzmo4uQ5i6k=;
        b=27SjUVy+euDz3fSQyBLMPT3ViiufHX6drgwP0UgGvVjWV/5z7dye0hTKa+rhxWdcSs
         Cj5o2SOouM1CGMtgXGTlU1OHA5lTYhVT6Si/Caa4/LQylh7HNCanJL8rKg299IilgvGy
         PYGZmvt4e5BcuRfIBj23PUCuxf7BzfIhUBL4CQCU/xgdVt3Rc7VPOY7LqS0rRGmEq1fI
         4kUJ3soM0uefADhvZipcx9ZHyquBQsvsZuRe6vfzcJebfKRa4DD9Yz4rxYX0re3GRtnb
         gO7u+BJ2HZME4V+ksnR7jZtKE3fpVDvgeXpMdQDGfbf0wvxkKIOGxarW24yp2NmgCpu4
         6QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706661295; x=1707266095;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jp6KKW0ZIX0DZ+zwbJajmfE3NHhPWe/Ixzmo4uQ5i6k=;
        b=dQLRGh2eTaJVJCnU9Kz/dylMwolZekvgoQfOXMLwo4K/Lni1ShS2iaEYuiG37p1lML
         p5/HNVGcDHJmxEcLoEThEwygwR56X90GxduVXKF8caFnHu+XoWPXtOrDKDrGwgHxWdpc
         8pS6dMKQud4l/QEDxld3Op6YT7Em8mXqmEGX/Czlp1B7oDUsGT3Bp8N3Oaf921BOodDj
         e5M7Db2EE5BNqWOnx1I6pdEoBXYX2ChyqcN6LMMWvf7FFb+X0Uz7hzNLQ9DKXSRMGGds
         PiV9YZGD0zRfmVp25qSHTH5EzZ3aAm8wv/qmWkNlcKKY/lAhnBYKaq78XFSysBP/mCnK
         dzVg==
X-Gm-Message-State: AOJu0YyH6e/uaUksQFqZxi+sbBxuU5fBkEUpEwqR8xIlsOLpbSs8tSYb
	NLzYEMhxj0lmm4bwOYEkptPZN4FuuRgCnKsboX2nEM7rxU2fgYN2cGnT2bChd6JDLVM9ga238OY
	E02A1dtGtKtChCNWrPPdiApjnMTE7Ixf2uWTOqaJno3uELgzrWoF0
X-Google-Smtp-Source: AGHT+IGfVD7AOH0HT4ce9FZUcbMS804it0tIIBGetX6GCtEC34L6LliwT1Vuuva9k/cFrN4s69tMPbLhExChqYlyglY=
X-Received: by 2002:a17:90a:d80e:b0:28e:6dfd:ad6c with SMTP id
 a14-20020a17090ad80e00b0028e6dfdad6cmr2942072pjv.10.1706661294888; Tue, 30
 Jan 2024 16:34:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Tingrun Chen <tchen168@asu.edu>
Date: Tue, 30 Jan 2024 17:30:35 -0700
Message-ID: <CAGjhMsg_bVKJ_zfsLUR32+oZwGDr3OiBHV_BJ3QtFjyKAs7Sgg@mail.gmail.com>
Subject: [Intel Alderlake CPUID issue]
To: linux-perf-users@vger.kernel.org
Cc: Ian Rogers <rogers.email@gmail.com>
Content-Type: text/plain; charset="UTF-8"

`perf test 7` fail on Alderlake virtual machine, The test is failing
as #system_tsc_freq has a zero value.Below is the output of `./perf
test 7 -vv`:
```
Couldn't bump rlimit(MEMLOCK), failures may take place when creating
BPF maps, etc
  7: Simple expression parser                                        :
--- start ---
test child forked, pid 82095
Using CPUID GenuineIntel-6-BA-2
parsing metric: 1+1
parsing metric: FOO+BAR
lookup(FOO): val 1.000000
lookup(BAR): val 2.000000
parsing metric: (BAR/2)%2
lookup(BAR): val 2.000000
parsing metric: 1 - -4
parsing metric: (FOO-1)*2 + (BAR/2)%2 - -4
lookup(FOO): val 1.000000
lookup(BAR): val 2.000000
parsing metric: 1-1 | 1
parsing metric: 1-1 & 1
parsing metric: min(1,2) + 1
parsing metric: max(1,2) + 1
parsing metric: 1+1 if 3*4 else 0
parsing metric: 100 if 1 else 200 if 1 else 300
parsing metric: 100 if 0 else 200 if 1 else 300
parsing metric: 100 if 1 else 200 if 0 else 300
parsing metric: 100 if 0 else 200 if 0 else 300
parsing metric: 1.1 + 2.1
parsing metric: .1 + 2.
parsing metric: d_ratio(1, 2)
parsing metric: d_ratio(2.5, 0)
parsing metric: 1.1 < 2.2
parsing metric: 2.2 > 1.1
parsing metric: 1.1 < 1.1
parsing metric: 2.2 > 2.2
parsing metric: 2.2 < 1.1
parsing metric: 1.1 > 2.2
parsing metric: 1.1e10 < 1.1e100
parsing metric: 1.1e2 > 1.1e-2
parsing metric: FOO/0
lookup(FOO): val 1.000000
division by zero
parsing metric: BAR/
lookup(BAR): val 2.000000
syntax error
parsing metric: FOO + BAR + BAZ + BOZO
parsing metric: EVENT1\,param\=?@ + EVENT2\,param\=?@
parsing metric: dash\-event1 - dash\-event2
parsing metric: EVENT1 if #smt_on else EVENT2
literal: #smt_on = 0.000000
parsing metric: EVENT1 if #core_wide else EVENT2
literal: #core_wide = 0.000000
parsing metric: 1.0 if EVENT1 > 100.0 else 1.0
parsing metric: 0 & EVENT1 > 0
parsing metric: EVENT1 > 0 & 0
parsing metric: 1 & EVENT1 > 0
parsing metric: EVENT1 > 0 & 1
parsing metric: 1 | EVENT1 > 0
parsing metric: EVENT1 > 0 | 1
parsing metric: 0 | EVENT1 > 0
parsing metric: EVENT1 > 0 | 0
parsing metric: #num_cpus_online
literal: #num_cpus_online = 8.000000
parsing metric: #num_cpus
literal: #num_cpus = 8.000000
parsing metric: #num_cores
literal: #num_cores = 8.000000
parsing metric: #num_dies
literal: #num_dies = 1.000000
parsing metric: #num_packages
literal: #num_packages = 1.000000
parsing metric: #system_tsc_freq
Failed to find TSC frequency in /proc/cpuinfoliteral: #system_tsc_freq
= 0.000000
FAILED tests/expr.c:249 #system_tsc_freq > 0
test child finished with -1
---- end ----
Simple expression parser: FAILED!
```
The test can pass in my AlderLakephysical machine. So, in my physical
machine it seems that in the `arch_get_tsc_freq`
(https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/arch/x86/util/tsc.c?h=perf-tools-next)
function, the call to `get_cpuid_0` will read a valid value for lvl,
then it will calculate the tsc using the information directly from the
intel instruction `cpuid`; however, in the virtual machine, the lvl
will be less than 0x15, then it will fall back to read `/proc/cpuinfo`
and it does not contain something like `@ 3.0GHz`. Interestingly, the
`model name` entry of `/proc/cpuinfo` in both my physical machine and
the virtual machine does not contain the frequency information like `@
3.0GHz`.
