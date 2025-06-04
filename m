Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E2017548;
	Wed,  4 Jun 2025 04:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749012045; cv=none; b=E1hUJdcfTyRAFVNQGdngH3+CmwJGc2djIVBwqEuXR8CgCnKi0wQIp2rFBFPEZBfPjjlztBpIWekc/VZKSgnVCTyM89wRvUkh4jweaWgHVyV03SOduwAfz+bWo6uKlL6+ijsmg3d+LoGNnNlG22washpACVyvCvZe7Tqke2bCq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749012045; c=relaxed/simple;
	bh=ZgbX+lwsAkjzaGPYBrOziBHAng2N+Ia2h5D3wr3cvMA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=a1LWdL6uHwSIOPxQWQHP5e4jdvgpOzuDb8d7mnDq6T0iHR47cjy8PI2S2jhhpMvSnPKcJ4vYOBvO8R/wVEbUhdA1any7hI99XWEpyO2ZtbgHN3gt8rHAI0aywXYb8bjf6ajpEktfZG01N+B5t+ajf8RLJ3eciZVk7Qvrsux3Z/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T34RA5cF; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T34RA5cF"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-55324587a53so527130e87.0;
        Tue, 03 Jun 2025 21:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749012042; x=1749616842; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BBwcT2Y3AdeFqGjIta7dk28dffezr6AYbELS+PC829Q=;
        b=T34RA5cFZcvgGk5Q6pEAlathUJtKdOlkF/NW2B6SFGCoIy/vcG1o9fXRUXMmEJ4Izr
         Jq3yHUo7SJr3keK9pPfKwkjrmLjH47LN6sBq98nuxEXA62BFwWOVhvT7MGJLi9+N3Vxa
         H9KPoFSlLLj6Pf3pTdcjrueUSrxBlg2hI+/0aQJHRHA+0hdlX4pijrA6pdTXs24lkf+S
         C4qF6cFRv4KGlmKxpwcjZm65xo0fL8i1UKflMJtRnGykMBC/+/5f50ujb12TyCJSFLfE
         4QiYYDfTs0s8W+x06uMWDeoOkn5M/xrOSYrBsX/NDvaaQ8689gY/2g+vQCbwU4sOdvy4
         YgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749012042; x=1749616842;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBwcT2Y3AdeFqGjIta7dk28dffezr6AYbELS+PC829Q=;
        b=IhcwGHoIrmpBkzQTIt6vxiX3m1dBN+AGpVzDQTdNkbK2ZCd56d5GTO/ntgsDspVdKb
         Cr9yMGh64YWSLV9mOhTYGR+TJlOTSppQhce9mSog9cce2mjDa3d0zhjAvTXcI2e08Q21
         f4wUYpaSI7WcJIg6IRa8sN1hIHB0LqDKNqNaBHxArQbYNXETMyGLUnxnCvsru/zRj0rP
         bvo1G3isyBDjRbWMJ7AbjUvB+sWNxRh7DiRNHMvsPPd7scCs0Cl8cjFAl8323aQrjb6j
         bBCtl2kLDApH1oH4PWyX2OQb6t20awtCR7q9lrPA4nBF3CpWTn9sZusQVXt1Rbt7LfH3
         ve6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVE/PmNMmuci00LVT69ybtg5ZlgQSN2XeNrJGWErME2+MfGhIKMuDG4tM8L2R4JwywMfxePBibtT6rkq0BGYoLrzw==@vger.kernel.org, AJvYcCXE1pzszUBAUmfclC4mHsgNNtLkb5gTIhj9IQuheWcIOL0Bac3tx3FkZ6VHuZ2bkUBZhWdgrX3sv14UuoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9q36++xGMksDc18sz3vM3RlZwGHQQy1hW/jm7fae+tpJtxvez
	r/ODPlsBm4TDCMp61NJCvzB7DFj4DXZAZoTAKvzEdZ8UUHsMBw9TBiVuHprtDO4URAHTnc3+ltI
	EjboQZzZu/JeHSLtbth5LQNgXGXdXQhg=
X-Gm-Gg: ASbGncuLafHLoaNZvO38WjepRkMs/OL1FxXkXAgzJLlB69smv4QkP0BB0yoCJhE6+Qw
	dttEtGtsrJDLV3UN49BQEPP2l5Lpd0W8+/xWqy9VrrQeTlU/vNFYiR5aWHA2gx8gxWml7CIpq8f
	88kOD2j+U8ajOwQn/O56GP748JtVTALtLlbH4=
X-Google-Smtp-Source: AGHT+IHZqiswRY+fLCTY2SYxo+yPwCSLeNxQFExZTtLGO20c2u3Go0kPNDFA9tdiDaWF8Mp3AXwUtgOooWiQ0WIVV7Q=
X-Received: by 2002:a05:6512:3f28:b0:550:e8b6:6996 with SMTP id
 2adb3069b0e04-5535315c114mr1434065e87.2.1749012041965; Tue, 03 Jun 2025
 21:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luka <luka.2016.cs@gmail.com>
Date: Wed, 4 Jun 2025 12:40:30 +0800
X-Gm-Features: AX0GCFv0gwTwReVMSJeOFrgjhgLxppQPcP4O-KuHCwh29kOjrUO2_v0Ieopskz0
Message-ID: <CALm_T+0ad=OMonZ+370GOXWGHV0+SS_i3zmkrpN==Mz8Aa8PKw@mail.gmail.com>
Subject: [Bug] WARNING in event_function in Linux kernel v6.12
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	"Liang, Kan" <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Kernel Maintainers,

I am writing to report a potential vulnerability identified in the
upstream Linux Kernel version v6.12, corresponding to the following
commit in the mainline repository:

Git Commit:  adc218676eef25575469234709c2d87185ca223a (tag: v6.12)

This issue was discovered during the testing of the Android 16 AOSP
kernel, which is based on Linux kernel version 6.12, specifically from
the AOSP kernel branch:

AOSP kernel branch: android16-6.12
Manifest path: kernel/common.git
Source URL:  https://android.googlesource.com/kernel/common/+/refs/heads/android16-6.12

Although this kernel branch is used in Android 16 development, its
base is aligned with the upstream Linux v6.12 release. I observed this
issue while conducting stability and fuzzing tests on the Android 16
platform and identified that the root cause lies in the upstream
codebase.


Bug Location: event_function+0x304/0x330 kernel/events/core.c:281

Bug Report: https://hastebin.com/share/egafotaqot.css

Entire Log: https://hastebin.com/share/miyonehava.perl


Thank you very much for your time and attention. I sincerely apologize
that I am currently unable to provide a reproducer for this issue.
However, I am actively working on reproducing the problem, and I will
make sure to share any findings or reproducing steps with you as soon
as they are available.

I greatly appreciate your efforts in maintaining the Linux kernel and
your attention to this matter.

Best regards,
Luka
