Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C35E24A18
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Oct 2023 21:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTwho0KL"
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7879DD6D;
	Fri, 20 Oct 2023 14:21:30 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c9daca2b85so10199725ad.1;
        Fri, 20 Oct 2023 14:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697836890; x=1698441690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zHo92/49NAsPxVN+ldMHzX2+gxwKYnAU2cxiDjQ5i9g=;
        b=LTwho0KLKcJ60XNW9GUu9gWoRwkl6peVyTYENPusd/Oin8m98aq5FXP4WvmE1R/WI7
         wP2wrxcL5kasskxNdRnvwJhu84TjHOEHcO8Tb1K70Ox99/kGA+FPH7y3oEyEwXh8KNld
         MmMUjsT2s1Tt+0ShT8FrqV5UVPcAhXl6P/tXBsXh9J30rtRgNep62vyLAYeUykI+MOXv
         Uv8uYg0iE1LgzKQJzcVRvQBcsq5Jlli3y3dUMGcsqJgko1c7k8X9dFYGlyEqSwFNMyQ1
         OGU71eemp7RRcNo/rE/QpXr9JomRbM47jZBieAIq7Bk2OZSbbe9Au5yYOBzKyHJLICDW
         xiyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697836890; x=1698441690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zHo92/49NAsPxVN+ldMHzX2+gxwKYnAU2cxiDjQ5i9g=;
        b=IXxUB41cKEsFgCrq4VmDtswKpanHMZ5uMLCpvsCF9362VlKUrU7+r5tSZ7yjhfggIo
         cKbfyuGvCZ+jMa/eeTCv7DDNM6RCZWp6hJe+3M72ooWr/tO/EyZBALms6yBHkd6Ds/eu
         igX+2tIrZo4V8+zAxrttImM8Nv9Ry8cIp579Sv7Ba2ikzw5XzndVBwdMmyhIYLzgWPPW
         dkFjyuAnYHZFHqNUatB11aO3KEhcBokh14gFYJFM5S1z6PV7eCZDER55mSgVXPdPSQdF
         dVJFJtLtLymznecpeFL/0h2K39rk1CHpymZhb3B35wSqHEJ5/AOwktlnBPa9r4pgRHDx
         kqlw==
X-Gm-Message-State: AOJu0YyXxOgwdav4YJcP9lWjR2en2lz8J0QC8dK++Ijay9LKop+Qe6KS
	DbaXVpJt8b4Lur9JvOxiJwV+g/jp1lA=
X-Google-Smtp-Source: AGHT+IFCOI2TW3kggLRtAipsD+TMXhN1VbinEcfhFcSs2VJfoP3ZizdQuNPWHC73Ci5AVh4arTLemA==
X-Received: by 2002:a17:902:c404:b0:1c3:e2eb:f79d with SMTP id k4-20020a170902c40400b001c3e2ebf79dmr9746863plk.8.1697836889915;
        Fri, 20 Oct 2023 14:21:29 -0700 (PDT)
Received: from moohyul.svl.corp.google.com ([2620:15c:2a3:200:5cd3:25e1:1589:ad95])
        by smtp.gmail.com with ESMTPSA id p9-20020a63e649000000b0057412d84d25sm1919583pgj.4.2023.10.20.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 14:21:29 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
To: irogers@google.com,
	linux-kernel@vger.kernel.org,
	iii@linux.ibm.com,
	Thomas Richter <tmricht@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org
Cc: sumanthk@linux.ibm.com,
	hca@linux.ibm.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	svens@linux.ibm.com,
	gor@linux.ibm.com
Subject: Re: [PATCH] perf trace: Use the right bpf_probe_read(_str) variant for reading user data
Date: Fri, 20 Oct 2023 14:21:15 -0700
Message-ID: <169783679849.2217970.1585610113132508409.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231019082642.3286650-1-tmricht@linux.ibm.com>
References: <20231019082642.3286650-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 19 Oct 2023 10:26:42 +0200, Thomas Richter wrote:
> Perf test case 111 Check open filename arg using perf trace + vfs_getname
> fails on s390. This is caused by a failing function
> bpf_probe_read() in file util/bpf_skel/augmented_raw_syscalls.bpf.c.
> 
> The root cause is the lookup by address. Function bpf_probe_read()
> is used. This function works only for architectures
> with ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE.
> 
> [...]

Applied to perf-tools-next, thanks!

