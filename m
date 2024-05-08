Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87F83612D;
	Wed,  8 May 2024 07:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715153953; cv=none; b=DNt15qnUt50TX85M0TAFoNOL8r+tbRu9H9hCIjqOSzqm1QmTYHG+AspOpELx5Z2clMuqYwIgVZLKH9bzFRv5dnUgOlgRkB9se5BfY9PyUhx0OqMktaZfeChBpNSijsfY2eT3++lkSRobw5bncN/DM2JQyrcW/YUPMyh0bXh1koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715153953; c=relaxed/simple;
	bh=f3LK0ObLAJurfNRZdpJ4wptu0daiM/YkDVKRX3RKV1o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KP2NDvth4YP0c8BupXcDeNNNzYEaEZQr+4LCqlDQvY0autsrFKhngP6IsJci/ImuDGXVfwdxhthpuHeb2qQWAR1b5GJZarPx1MSGz2b2uzFusCAPS1FhicHBlHrH6RntO3T716fWInF6E+EdFw2CI9qXnUBO25s34KWDcU0CsK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+IoIWuH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+IoIWuH"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f3761c96aso5193446e87.3;
        Wed, 08 May 2024 00:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715153950; x=1715758750; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HQn9AgRFMdHrqQQjouGtyxcYjF50ckhpwWQdA7LsrIo=;
        b=Q+IoIWuHnRMmiDmQTcp8jyTlj6gIj2HIKxvYilxhTwWrpkTEZMaSnFUsWwouyp2XHw
         N2+ml2E+xSN5Hx73KmkRhVWU/US07nnSw6JXxv20kEBV/VZW0weJmdSQ9lSSRecsF8Io
         o06IPjMCyEp/ZHp02FqzfnGezqMNuvUdOHgwe6qRmjC/zEVDAt0+rv2QrSk4JhSM5Ih2
         dzlBiRKj0WUHVe5+CZBO2kfCXQl2bMkfzn/dSaKL6/RSMs11jJWQZoIF8//IfC+PiyJQ
         lhD0JBZ4F9gA+0LU+Q1TpSlZDAcBbJudKf1/70nzpJb4sdi7WMDKWp4+vFnLTy5luir1
         we+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715153950; x=1715758750;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQn9AgRFMdHrqQQjouGtyxcYjF50ckhpwWQdA7LsrIo=;
        b=r8orGBLHyWifQ7WCMir0J/E7TtxaJxWqs+iySAnXr5w1aWTuukvGgTe84ekeI3ow9k
         U/e4/VGklG9wtJrVWY3ixCC4CEJH6yG8EwteO09CMQFhyQQhLvH4vHnKsyX0C7uZHPgd
         eVFp/eO6s1dwYi2Tt/5wDWqriZym4TylVzw0juiDeukACH5iWHB//jy79pVl35TBESYu
         Wma9BdP3yc7xkgqjcQzZAOvk9jwLlqwWUt1yoajXuT1p+GLHty3YYpYIuxXq//ZpM/ct
         2Q5tO0zN7gu8o0Q85vTB92Tvb2D4iyFhkLBKenmAeJadvwohmh9jHe1mkW/LHPudT9V0
         ApPQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/48CW23wr1d6O1ejm3Tq7+LfQTMZOwBR4bBaQ6kOc309Q4md4qQpf16KRQWo2V4nHXJhN8NSzyPzBrwUZ1Y0A7NLHONQ3gEBQoex3YF5UKi0qPgmTCnx8aUOTpOsLMK2yIn97VX0W96l1oUVmcw==
X-Gm-Message-State: AOJu0YyXEL51cBqS/rDM1XmOk9tqc1nOgvyBzAlnHOxKaQPg4JTV2yi8
	9aCUdAm3W0XnrYmORc8uGvG8+ObfmTK9qXsmmgMnBbHwJNcs5Pp9bN2Ns7yj
X-Google-Smtp-Source: AGHT+IFpFo8eT1Te9z3lKdN3VNhEIZaSFYvju61jJNNZjUVEuLpM4ZukvEkmhQvpPaRHFMkzaPibIQ==
X-Received: by 2002:a05:6512:3b28:b0:51d:1d42:3eef with SMTP id 2adb3069b0e04-5217c6673f2mr2056665e87.29.1715153949372;
        Wed, 08 May 2024 00:39:09 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c254bfsm12859855e9.17.2024.05.08.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 00:39:08 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 8 May 2024 09:39:06 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h.  Stop.
Message-ID: <ZjssGrj+abyC6mYP@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


So I've been getting this perf build failure for some time:

  kepler:~/tip/tools/perf> make clean
  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
  make: *** [Makefile:90: clean] Error 2

... but if I clone a new repository, it works fine, until a point.

'make clean' doesn't work - and 'make mrproper' in the main kernel 
directory doesn't clean up properly.

Only if I do a brute-force:

	rm -rf tools/
	git checkout HEAD -f

does it get resolved.

The failure condition triggers if I Ctrl-C the following build a couple of 
times, without it being finished:


   cd tools/perf; make clean install
   ...

   LD      util/perf-in.o
   LD      perf-in.o
   CC      pmu-events/pmu-events.o
 ^Cmake[3]: *** [pmu-events/Build:43: pmu-events/pmu-events.o] Interrupt
 make[2]: *** [Makefile.perf:709: pmu-events/pmu-events-in.o] Interrupt
 make[1]: *** [Makefile.perf:264: sub-make] Interrupt
 make: *** [Makefile:113: install] Interrupt
 kepler:~/tip> perfi
 Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
 make: *** [Makefile:90: clean] Error 2

Thanks,

	Ingo
