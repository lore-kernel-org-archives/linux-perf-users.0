Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B2C379971
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Aug 2026 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787018930; cv=none; b=HOvQym2/ZYqUVTaG8l8WzYo8MlXBWLMKkrlnFuCZE6pBaBJnguoNFv8xE6guGsCJhyY9PyqQdZhm+Bg3g5+pYpZY3CW9uVvXDtauL6ziJvMSeZkqvuELrFHAn3Z0jBIJPX4Ys40wwJc2V6+iNqd9YJ2LsGodDgFdUPhS0vWnXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787018930; c=relaxed/simple;
	bh=0+3TpIP9W6OJAW8md/fqGRGsABtzg7Bvl8LSFl05BTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az67bphxStrYFaXt4RJpdWzM7iHYkDn3nNOoSkr6g4w0ZNUymU+vQma8LOTEEzHgO8JLrcERgvkwsXiC04osDmYjGOXtgGawU46fIMeQj0gpD5zb3Wrr64ucpi+QsVaC/2Er6DIyJSzP8LQEgZERhE6NltDzBsr6eVrlp/3blP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W80XRoan; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W80XRoan"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso3385480b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 19:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787018928; x=1787623728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u5wmrIQ8d/D4bIJXHdHl7S0yAKn1Zat0Tny3LAFduno=;
        b=W80XRoancL3eQB9HGTwIu9T1AJ20JwLELXQUoO9MNMagLBZBwxBr1uIYrB6hyHiQ5B
         HZ/TXDgkJgYmqfaNsMD7H+urmJM6B/P86s6Vs/sG90BfRjuNQ1K77hxDaedmh3Yd5k6y
         4k8My+8dwVYNCV5e/27p62/OlyVpJq/1AuX6lAiaDaRRCxJ4OugArlnYR3Cg8WPs6kuR
         t5xRovXlh6bDnEiqQMvciBmtW9ZXhUrxsOhEkBhXnRKc+IVBgxdNVkBHkqbeqQS73xxd
         5dqbRoJFvUsl4lLemTGYcJ5nuxeyClGpV+7aWPsR8kVmX4UEH2t1eHbKImzdjIAp/jzu
         WYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787018928; x=1787623728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=u5wmrIQ8d/D4bIJXHdHl7S0yAKn1Zat0Tny3LAFduno=;
        b=N3vmZEzr31jhT/0aaLZtA0fg0aaGPtiDjl1zHZF5nAGzM/mv+Pxdzq3kdL444ndk7Y
         Ak7rjSMthbov4/hdfR/P3X4lx7JSsWR3XSDVEaBz7yS06oejRjfIglTe3UP82ugezLeZ
         G0gJobCRLw8O+s4cQ0HDZhf2y4pw2jdL4Ajwxsvpcte9P23kqFDj9Y1nwhNib9V6+pht
         PlvrhpOnH7YoSs9dfdzdx0pKSCAAVlu9yyq3YyDbPvPamda6+a1xBfW6T97dQ68A1Oe9
         GCdsnlpDsIma3kJkAGYyezelN1Hf7VKqljHhtlBE7dXH2PbswRimppFX6C4HMAvWbaAA
         oARA==
X-Forwarded-Encrypted: i=1; AHgh+RpWPww9jzriS4Lt9bK1h7unC0Lpf1fKiQ0IKvnkARhVpF9rK/xFQnyUUA4Y5vWjXwEMn0bpyMq8KUASNponSQBf@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUkjjwmvWwvHQIin/Bd9eEGWkw1Z0UsPpQx7ZDCCVEWiSi6R+
	ntJFwj1pg1OrAnZOCJPvnPP1iOoXIdu1bIvXRMeyJdlV9IpPojtDsS/B
X-Gm-Gg: AR+sD130P79ZBFViunYqHmYGjmaF3DXNr3OaqsoA4kBVfX7uGhUbanVvSL4vJp8mRPq
	V+cPEvIAEyDkUR4OB93tzjhepOhnxr9abSCDBP71kd/K4u1h95tstwSkVs4rUcE8ZlogPhnQov6
	hYA1w1VGYbQiYzQzkA7Jq+A3IrPfwExeP+sh7jm+0i2YyFePAuNOzGvMPnTcKItp7FlEbk8wCPs
	+KgajsP/KiRsrJXGpqtaRFMD8JnpZz5PqNjBZvrjV6OCgRUm5GdZkfcscjVbpivwqilPShgwGEh
	aoFzetqCAKvp1lZfCyHPZe0FfybjLpUY52ZStpTm1uybhMm1IofRoVKKPbdVRyNttiUkgd7HXZ2
	x/D1u6C/o+5u4fEb8SQjA8nbKO6zNyzFEZDCOLlYz5KfpghAWIg0FQ2AYxw+w4muLeoSqqELaCL
	3JvGhnia86eLr6LoocO4UAOzf+ADwG9nQPdAn/bZ2v7+8W29HdSV0p8YLIGuzW+ptf6e9MQMtsX
	Q==
X-Received: by 2002:a05:6a00:ccf:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-851b87a36cdmr5479823b3a.4.1787018928462;
        Mon, 17 Aug 2026 19:08:48 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851b404944bsm1216138b3a.23.2026.08.17.19.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 19:08:47 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Ian Rogers <irogers@google.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf symbols: Don't apply the symfs layout to synthesised paths
Date: Tue, 18 Aug 2026 10:08:39 +0800
Message-ID: <20260818020840.56874-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAP-5=fV0sqh1cVc1kxSPNV0mBS7V0oTLQDvybE3MZCnpQ7N0RQ@mail.gmail.com>
References: <20260811050046.4019578-1-zhanxusheng@xiaomi.com> <CAP-5=fV0sqh1cVc1kxSPNV0mBS7V0oTLQDvybE3MZCnpQ7N0RQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 17 Aug 2026 14:42:26 -0700, Ian Rogers wrote:
> Would it be possible to provide a before and after the
> patch so we can better appreciate the issue you are fixing?

Two builds of 8d3ae59288f1 differing only by the patch, empty /tmp/s:

  perf record -o pd.data -- sleep 0.3
  strace -f -e trace=openat,newfstatat \
      perf report -i pd.data --symfs /tmp/s,flat --stdio

15 paths get tried under /tmp/s.  Four of them differ.  Before:

  /tmp/s/debug/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
  /tmp/s/debug/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
  /tmp/s/debug/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2.debug
  /tmp/s/f5/8808c9c8a388055b126492a1706d732761f86e.debug

After:

  /tmp/s//usr/lib/debug/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
  /tmp/s//usr/lib/debug/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2
  /tmp/s//usr/lib/debug/usr/lib/x86_64-linux-gnu/ld-linux-x86-64.so.2.debug
  /tmp/s//usr/lib/debug/.build-id/f5/8808c9c8a388055b126492a1706d732761f86e.debug

The first three are FEDORA, UBUNTU and MIXEDUP_UBUNTU, the fourth
BUILDID_DEBUGINFO.  What the old ones have in common is the shape: the
prefix perf supplied is flattened while dso__long_name() is still appended
whole, so they follow neither 'flat' nor 'hierarchy'.

Among the 11 unchanged paths are the basename lookups the option exists
for, so it keeps working:

  /tmp/s/ld-linux-x86-64.so.2
  /tmp/s/sleep
  /tmp/s/vmlinux

The same trace with ,hierarchy is identical between the two builds.  The
doubled slash is path__join() on a component starting with '/', present
without the patch too, in 7 of the 15.

I will add this to the changelog in v2.

Thanks,
Zhan Xusheng
