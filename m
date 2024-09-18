Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFC28EF;
	Wed, 18 Sep 2024 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726659335; cv=none; b=ByzT1F2+ThihnavPZI0qXvbPWZ+3QTge3HBgbEECgbKAvCdHDyQhvZPNyXVcV4aJNx/SLCv+UR9ncP7y9oC1LjxLC4Y0jnpjH+EhEBhAo3O/2iv4GFvvEAnOyMb8NZZWrPnQkHiqzt4qt6VWZXgbExl2w6X6Zpi/BMK2EprTqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726659335; c=relaxed/simple;
	bh=ovxya7lXdEGnE0A+EuzKwD5pxlYykPJgGWx2fudUCUE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Hs/2dFLEJ0GPAzhO3OufT5+I3CyMt1cgXbFdkL4LZLvFqyKuDZcY7n9YpUuLI2N6XlBEEhoONZQXVRL3xIbCZ7iDarUdSCv4QOccl2TTmDIV9sVjq41eCSmEf8P7g3rCRxhZ/HXxqR3JoyV++ykjaof8YU7SvVvEmzKBiKKAvjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKd0aTU8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKd0aTU8"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-374c5bab490so428106f8f.1;
        Wed, 18 Sep 2024 04:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726659332; x=1727264132; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Krs8Km71K3DpWJhmegxLANswkZJOZp+boIvmDijJFk8=;
        b=nKd0aTU8kXYHbN/TuRrxfaaId5nOcC9NGQV7KJUYqT4s28st5rmfuz9QNmFFhm8HAs
         mX0T0Eu0yRNUTCPvD9Hrz0RekC2cb3p+tTEi/MdPMctddB4Y2YC8OBWnHnznW58gdIIq
         leJ3SMDM5NxNNNLqHjcoX7BaUDSTe/e+lrV/woDWSpzIAJcgRVbNaO1hsJfEEFqaZ244
         6elrk+y0B+01rZmh8gY0NknCt6p1FxfUwMI6e3GpdPvUv0TgOIm/1BOpwggztQJkD7rv
         T/oSyEaW+JiF98+yxWYK3IJzlnqu7Tgs1IblsFb2fI2KrlNeSzyPs1T/hmXNn+J15agq
         N2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726659332; x=1727264132;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Krs8Km71K3DpWJhmegxLANswkZJOZp+boIvmDijJFk8=;
        b=w1nGRM9xBWrXSvNmiQOOlyIJQnwl/GdbvFpIKBl1Drf6z0lryP2wxt4SHBgwHmovEV
         6tLJC7OWL5mjFBuLn14o/KXCINbAKB7e3XOStWRU9gYFb1/PUX2Q/511iWCbNnn1rnx8
         9L5ozUXGqPg6xID+R1MYGARYyjsywvwvFJfmTpY9sxoXWb/wu890H73Mbis9v6HgkBzt
         nNKcmc5ZFoQ3BNTqIgVOc+VLikERlqrbuclnVld0J/vwbbTa87xnbOE/9lMURVyHjldX
         MSq/2qbxhcWBW3XgX+3yF0f1lYSD99fQk0XLeCJZgz0zN2Vvc1Et7yvxxcskhYaeyEYa
         MuOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT4fz+90WMjWRij6/IjfVX59GuCmqVhyhwEjDX8CyJSmKVLw7FhNhhKEy6xcY3Xj+UmY0jxP7chDfdThbtV3mF@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlVmsqJA3iwB6LjAwMSqsVNxTsFmqQfLw/hnKczi1iy3X2sun
	QmjfJyr5HZS89w3QWHDudVrCMO2dOks4QtpV7W5nUfPL3WZG6PlS
X-Google-Smtp-Source: AGHT+IGdkfsM44HHj8mo1ejS+zbYGHgt+eRp8px3a+f3p69efwS4LCzFULnyNYMMDsJ7wyfgvZdiLw==
X-Received: by 2002:a5d:5d81:0:b0:374:bb1a:eebb with SMTP id ffacd0b85a97d-378c5e5d6a3mr10472989f8f.25.1726659331614;
        Wed, 18 Sep 2024 04:35:31 -0700 (PDT)
Received: from gmail.com (1F2EF419.nat.pool.telekom.hu. [31.46.244.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80afsm12028647f8f.38.2024.09.18.04.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 04:35:31 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 18 Sep 2024 13:35:29 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Jiri Olsa <jolsa@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] Performance events fixes left over from v6.11
Message-ID: <Zuq7AXjknK8ooci6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Linus,

Please pull the latest perf/urgent Git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf-urgent-2024-09-18

   # HEAD: ef493f4b122d6b14a6de111d1acac1eab1d673b0 perf/x86/intel: Allow to setup LBR for counting event for BPF

Perf events fixes left over from the v6.11 cycle:

 - Fix energy-pkg event enumeration on certain AMD CPUs
 - Set up the LBR branch stack for BPF counting events too

 Thanks,

	Ingo

------------------>
Dhananjay Ugwekar (1):
      perf/x86/rapl: Fix the energy-pkg event for AMD CPUs

Kan Liang (1):
      perf/x86/intel: Allow to setup LBR for counting event for BPF


 arch/x86/events/intel/core.c |  8 ++++++--
 arch/x86/events/rapl.c       | 47 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 7 deletions(-)
