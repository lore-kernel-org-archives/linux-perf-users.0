Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7F2222D5
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Mar 2025 16:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741364745; cv=none; b=MpIg79DDh+RR21BkKMLV31GSx/3LHLFZnAa+Rj9quEmVl1SM7zZq43YJidfw5y3f6gTMRntetR3b1pIz31YpKPfgOVufAf5OqtHS/0KzpmSQQFqcBuCPCYVhaapC3Crdm+wp18lfkoLAfCXDgzMF0x0knO8Yl4UQdOj7ycXh5w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741364745; c=relaxed/simple;
	bh=n839t0TZAIaKApDmgqbTzNnd2/MOtjprVshX9jwNIu4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type; b=cPF/KPjlt/aOxEQuQD7FhmbxvpvNXMl5j0E5+0HRTg2Es736QaaSvUmgjgnpGUJsBtVNsITYwmRSZfkt0tRXP9+1vOPhcLCSgZeSB0F+fg5QmoFtMgxudcOvUDBABlsrzZhyNp3O9+nQNXZHoWEqFl15i+zJ4UNo8hv0YcJbAtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hlPIkE/V; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlPIkE/V"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223959039f4so43622295ad.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 08:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741364743; x=1741969543; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAsM162L6ZuOBpnU92NPqOBKsQEoH8sGfaTZh8ecsTM=;
        b=hlPIkE/V4MucAMnnEG2zNsmBOcVBAmUGTLmtppVtvTEuM784P01EH4SwvBTFTwMbdz
         ZfZecHzSS/0H9lPpcp8DKIe7c+pJZ/ibDwxE0Ln6K48AkV5SHCEHF8dBAHz5VP866jSu
         QfTSodQ8zsAA6CWINXe7iVEsVt7m9/qqcAADrK6hP76svL/+xCyRKODcC95eezB5tFom
         wak/xaC3hoJ8lqbShnMDZgAPKPzE7Ruce6raaOTUjY6B5EnUN5Mq6YL3ei/NRvKLa1CA
         AYQqiJypEVQo/jsLK4Yl5NKWrzj563mf7gaTygE4HKvRmcZcv+rhC/neuiwDkFM/obMA
         M7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741364743; x=1741969543;
        h=content-transfer-encoding:cc:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MAsM162L6ZuOBpnU92NPqOBKsQEoH8sGfaTZh8ecsTM=;
        b=nbyWtfRakUr4D31b5DPK2h+ICPaWuhqKFUAOEKOLtph4c0p1PJ6bwPAYINbiY9nB4q
         NC/kiQfZljFKX2McEyQPX7v5cOdjipKJYbEi62HA/QM7NpCsbz9t70GgPEleKEuVdmZS
         sPHZeDHsT0QaQeZi5oTiiHvQvCejacmYUYqWn39etdJ57K82b2V8UfVnRtZlPO1QhMcO
         GDJnM0dxCUjx+FldtoV4i6P5M+Ca+d3ykRGMH14l5Drh+tU2Pnvz9BQZ4anL1lT/LEHx
         358Iyk8OH2pX0/z5vNBdY3DhO1gN49w3TEYa6vEpSVo4k+7eSdKmM+2lSgX/Me4U/wCe
         lu3w==
X-Gm-Message-State: AOJu0YwMQYoVYNLSznbdyqV3IWkZgJbPZhHI1DeibPxfwkv2oyqFmQ8H
	ufhEch4m2obvgv8iogCM6o4+KmzsAnD/kVYFMAnEyeM56HaelN1R2/vO5Ihk
X-Gm-Gg: ASbGnctgI7EHSqScKQcR0SyXFVHeaLVTXEruCD/84S6S2ciOhy6fzTd4Ns2lHHL7A3s
	15tD+1RX/6jw/YO9ROB7vAfcaMD8rt2dsrdw6BfW3hkDNP0JZ1X/QJ56/mvyayttO4FrXvtKKC1
	+iYX3ovXZ6RwXy0Xa4O2NFva5I9Mps+WHI4IPJHll9wq75iCsHFMkK5m7EmJciB3GEe6NEvE6+8
	3+MdcMvH65eEWT1RBI/uibXxE6eSBiY0FQo6PiEl7oW7U9ZzwJVL8/56NenJF4Nv8N2XeEjXu8u
	tDCctYN6J8UtBRO6q75QnnFFKcPeI8z+SyKu1tu+Ct7Mh86AR2xFJy4=
X-Google-Smtp-Source: AGHT+IGPr7O8qloo836uyR+E4hlZ1KUBwbs0srn47xWx0bUZ+EeIKODcVoQgRLOpMBHlYqsYknsA3w==
X-Received: by 2002:a05:6a00:1a93:b0:736:4abf:2961 with SMTP id d2e1a72fcca58-736aaabeef7mr4733931b3a.17.1741364743220;
        Fri, 07 Mar 2025 08:25:43 -0800 (PST)
Received: from [10.66.140.154] ([138.199.21.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736984f75afsm3426026b3a.114.2025.03.07.08.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 08:25:42 -0800 (PST)
Message-ID: <f3d4363e-1de6-4817-b45e-fb2a05f02723@gmail.com>
Date: Fri, 7 Mar 2025 11:25:39 -0500
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: peterz@infradead.org
From: David <davidzgumberg@gmail.com>
Subject: perf: Live mode flamegraph recording results in segmentation fault
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've reproduced this on recent versions of Debian, Ubuntu, CentOS, and 
Fedora,
and I used to be able to downgrade perf and it would work, but an early 
enough
version of perf is no longer available from most package repositories.

Steps I have taken to reproduce:

1. Install perf from a distro package manager. ( `sudo dnf install perf`)

```
  $ perf --version

perf version 6.13.5-200.fc41.x86_64)
```

2. Attempt a live flamegraph report:

```

$ perf script flamegraph ls
/usr/libexec/perf-core/scripts/python/bin/flamegraph-report: line 3:  
1644 Segmentation fault      (core dumped) perf script -s 
"$PERF_EXEC_PATH"/scripts/python/flamegraph.py -- "$@"
```

