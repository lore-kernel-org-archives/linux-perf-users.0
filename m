Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794978260;
	b=30H2yaZQcib+kvI0NS5SS4uy/y/M3Z9fkGJLxIksFw0BiV4iLdyjZxGM3JHhcwjFtgr4
	 9h0lxhoYo4hKLYytEJUgUS6LMbPd5drJXAwp5EKsVxMEe/6JX0vk9T1OAIOq7b5ZjsReP
	 7Q8QZGALdM/oabadD+SpcWmRioYYJPRb6Pp/v6lk0FQWclAdiPh4yE0i7obRFvKoSGwQV
	 Jn+VBZiD54Ql4Bb0ud5adBhwlvYta3TrO+rtJBp7ONR/UUAwBRoZC2TOB8HqDYKkzHzFU
	 GBwXaiiIkamgCrZnb5WbLvNjgnJLZBYqKgOxFaoN0tGjBn12lZHT7hNrb+RGXMHwAqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794978260;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	b=uzzkPUZD3xVgryX7T/2sCA7+OGW43QBgngoA+t9TXaPWPpVdUcy8o5Kx8+kGspwFiH02
	 Jm2zP0t+Y20Qj5pXTzcn8yONkUx+LYIWfoNp4NH66KvsEXfOLBYQHq7izBsB+Mg396QJo
	 MmIDSjxbqttoTOfcZBSb+CCFtUpT0C8FFJDrsHcwn8rpJvE2iFe0F5B4RIswadxMtjSyl
	 BvgoN8r/xd3glPBHWt+sloOCH4V8MKkicuDFD5ICpugfmYfvQp5+ha2+CDuxXp8Wd9Ejw
	 t5liXCZSYLx6FCbo52XpY7FTDCRP6kJR9w/DjXAY7xTubrHtnXNfV6gKrhxokRRNIsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AD1606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 05:04:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44AD1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4fb73e868aaso687275b6e.0
        for <linux-perf-users@vger.kernel.org>; Tue, 17 Nov 2026 21:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794978259; x=1795583059;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=DV8bLwrBLPPkcbmnn5n2AtUBal6QZvw7PFfq4fX+cgchFCsv2VqNhFxdqVDgIDZSwT
         ULGgOYVRzpML0Z1pLiS+NLoxNgecAnoGFvurKT+QeRgoJTBmRj6qPcoIBFGdTJFBzkLK
         uUe2Ca0SDOjfzp3wVQSjp9ONNgOLBuW+6AObLMXbJunaYiMXTRRUkvmUkbDsX7034xqq
         8R3niidaBma+C/jAJQJBIgFAnKAR4m5BxUBCKOCgJi3cw1YeHSEGXK6Lv9qwLHfx5sML
         Cu+/4DGL/otneeFQU2UZsQBm+2TrxgSfnQsg2RTtYiZrTcVJOvccC1VXNAFFp1uGmzOO
         +Uuw==
X-Forwarded-Encrypted: i=1; AL+hErFt8L/kNJ90kaY7kVfhaW1AXVIXtWnFx11aU4Wu2lbp4uZGdcv8TKIsvI5QYqQ/OBxAe1BJRHETi+k9TO0V9t0Y@vger.kernel.org
X-Gm-Message-State: APuU4Z933ku8Aug9j2qha0ZMpidZ1IELED6HNKsqIrK/ly8X6ai1H06B
	+Iy3U1jkq65dCrY2WGIKVVyf3vgqxkKiZNuYVmw3/ydnb6/oPVWGDuMrsMPZ3YgsoL8m72m+VRJ
	CMvjxr4sF5yqAITEpa/x0SJXgXV7Neoxskc03TmpMxc08T8qzj28RVg9NfiQ=
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4fcb:b0:574:82cd:a022 with SMTP id
 5614622812f47-57741c1eea6mr2354609b6e.15.1794978259303; Tue, 17 Nov 2026
 21:04:19 -0800 (PST)
Date: Tue, 17 Nov 2026 21:04:19 -0800
In-Reply-To: <6a8bd0a6.91706f20.16b6e3.02ce.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6afd31d3.8f566acc.2517be.0016.GAE@google.com>
Subject: Re: [moderation] KASAN: slab-use-after-free Read in uprobe_mmap (2)
From: syzbot <syzbot+1340ad4350ad43394c10@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	mingo@redhat.com, namhyung@kernel.org, peterz@infradead.org, 
	rostedt@goodmis.org, syzkaller-upstream-moderation@googlegroups.com, 
	zafir.taufik@starlabs.sg
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
