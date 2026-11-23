Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795471366;
	b=lD8hqncx5Ge5OgSMS6E+BKhsjY1S1uLjX19MdwOHK1Sh9B3B8llxMNu4jcLsmnXlax8h
	 +u9h3VL2/hwZG21xwQfoxgloT4pX1rrolY1lO086VvmIqvYGGeB8NBauPSlOFYRavGwXL
	 wnP3OdQPdeH0Yqp/oRJ18+BPQy2Bx7cgXLPHQn1CtmQhQpyiiR2JkTo7Kyvp8qYNpLIvb
	 UH76eeM9vFiFtsIFz4hrFIiHY0jY/34yT6bgwY3tOes7sIAICizHiszSz8WYJuH7Q+Uwq
	 zIjcCJGSXgQyCdY0c8rzQU5KAbUhuF9mvF62HRq/AiVHVEpFlRB1BxbhO6DwqIDOLaQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471366;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Gb6DgtVLri6HlWCnlbeYURxMYIY8vv9BF07dIcJu0Vk=;
	b=lNOVtg4yxYjtuOfb5MWELGXH8MH/9hGnUNvNN43OCl2CNiGHQm6rs7dEG3znOY62ChEG
	 3tmSzC9AWDYUrGX0ITaXqX3Kxhd9GHar5sODR38GYourpRainst5OYM5YHNKJnBmAZLvV
	 i+aHjjH76x+pEKMQOcpy98CC5HifpH7h89hQAwGCl15vvjB5gR3Rmx4delJ2FbynhXFmY
	 quRgb3wQfbKLwHTDcbv1VmGK6byGwh6ceTh3ZKwARbXqP0kK4r+ZCYTdKchoKA+zJBfnT
	 LxFRP18TKVSAfctQ73zgYKLfcR72DmUPry6XVaqQhVksMMdZl22MDFYYj+N+tyDl0+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=uber.com;
	spf=fail smtp.mailfrom=uber.com;
	dkim=pass header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=JxPpTvuE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E5E606A321
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 22:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96E5E606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=uber.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=uber.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=uber.com header.i=@uber.com header.a=rsa-sha256 header.s=google header.b=JxPpTvuE
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67da62357acso5079079d50.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Nov 2026 14:02:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795471365; cv=none;
        d=google.com; s=arc-20260327;
        b=nqVm9Ot+f3TC7hpe3xSHPHSGyJWxnplpUTPVLJ8Yk8UOOkNK51/Dqzwtw2X0sVHm6U
         3OCIpg8Rosvyls9icMwP/JipXnTJlRfXav9Mu7dNu7c09Le3EZUVvpOX6t4ZsRoTfKLq
         z/trzITW09nPw6Q+BtjhdJ/GdlVodeivURm1SiC218XkzxP9jthBk0iAoPiuTNzvh8Zz
         SKVRuUqLuDnjUm5sp+DqL9OX490Brv2dVX4mDPGhm+ko3qHQF52MhMXApaYexZXKwMLT
         A95sh0O2ivc8oMIL8jJBqS3gaeY1dVYIBpv4VMyuZEdUn8RWoTO3f24hE+0HSGXjgfyP
         HQsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Gb6DgtVLri6HlWCnlbeYURxMYIY8vv9BF07dIcJu0Vk=;
        fh=aZgSV53me+PDHd8+rB08vK/cZRzocWwvitzaDqtQ/EY=;
        b=e4Z/HLVOVbw3hx0xspA5RA/qP9Ms79IhSSJpJ+8hFKqyw/j6/m1U8f7RE46u0lFtlJ
         ueKO8HpTaFVHiT9wsSaJAkmsPC7O2mpCC9c7KG4MXezmMvBeeL+Tmh2Hot6SsVKuv0c8
         ncoNKR0BZOKp/btvW6ZNF3sVukl8h/UrdmSRPLQYZhalSHATcOrNztMRE6j0QlItHKYw
         uQz/QSdWfGae1Cy0waTEMLRIYrOsf3uQqOsi9G/61gUQNAnrw3QUjuDC/yuf1vhNyNle
         8kUVUBlvgsXMBCZV0kfYPnUY5qLaeLysaaz3Cfp0pxQGQUiaCPTtlaiIwh2JO60G48FC
         mTgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uber.com; s=google; t=1795471365; x=1796076165; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Gb6DgtVLri6HlWCnlbeYURxMYIY8vv9BF07dIcJu0Vk=;
        b=JxPpTvuE6beLmQdskx7fQg1ldM6upxH9Kv0vXET6tEKU38PhvbNxeEpIdeyIGe+W91
         2/+kvV7CAnH0JSH5unf4nlH6NwTvTY0C1WmdFB1LK8Mt0YUhDIYDK+Pl+w4exOg+2HjX
         ywPhcgiWQojTX/qc2EXpZ18olOv6mcCybnP+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471365; x=1796076165;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Gb6DgtVLri6HlWCnlbeYURxMYIY8vv9BF07dIcJu0Vk=;
        b=effvFCsAGbABLmdQJCekxAcO+1XLGAfEp53jzoD4OwGO/PfH0LSCEFCPTw27KO4tu6
         c3sr3pshIUmjFGqnDcfPnmZe2zVPaI2jcnoYPgKzcv2BaFNZvcGiB/LbgAHhqD8Tne3I
         4OyJKqDZ1bbJS2DI7wrpvqim/D0AGdzJD0B2DP4Mg+zt8GtKdEavEB2FQ24sAB5GJk2x
         15L7IX6aFu4wsD/JUGVGbFP3SdjrY4L+iqxr8OrfNMyOHh1lHm4l/Jmsh7+eyFvAhx7/
         6B5tqz2IaCoQMaxm7pBkiqKb8Ib5G8uoxWX87SOBgFtCzR3yRfqliViL1Z2J/UTEC3ha
         ooUA==
X-Forwarded-Encrypted: i=1; AL+hErE1WOCzfxFkjQVi4GtKrcNjwOmQUnkhRr2Jb6KQwBh/qvujKsmuVLNeqAuXtfqgubbrQk0uhCQnGcFOdFJ/d3i4@vger.kernel.org
X-Gm-Message-State: APuU4Z+1m0HhhUjsH/IX+q3gWdX9wepx9WI0UgPnYVBhFDtDxFDhxLHw
	75WoZRE4KdUAt5v5wxRc0udlhZc+OAf5GX7uXj1/XZLwGAz94AdD16HZ1eqL9tSGMYVwR4TDSH4
	m3zzlrY29oQ8+xrgoqp2WRd1Y7XR13TVRkPARu0wjBw==
X-Gm-Gg: AZFdTZcZj8rbvef31eplhOYlhdeeBjK7s4pye43o6BtHYq7ERHsIANgQO094vTrkVEc
	apPV2k2KwLv5oMTZVHpKMXnI+R2yu9NodGR/ybc8hQKFyR4Llb4BzBiwE0YDHLHcUERuWbwbmqS
	PVaiHTrueup61R5KDyQZaZxIbPn3PChfeYJqmBFbhJY8sg9Gv0kFSbz1G5fbnjl+MV18GsSTukm
	qZGWqmIYmvqyqLMdJBRAAduQbbHH0vFzXyiQwYJ8YCSJUjIUpltIoAPqFr6nGQs/NTRqmzGB8Wj
	YS9fd9xRkJH1SSff3+XUCka2DZycTiqvI88U5AEInnR/hXa/+aJFI6Qcdtrjh+2aFaTIPVBKTHJ
	YhYSAgoKrM5qR3s6/9y5OqrG46UrN1ogrbdotvIS7CsEFZW4ItYuWYJyGukP2i/K0MbmbYw==
X-Received: by 2002:a05:690e:439b:b0:679:ab08:5285 with SMTP id
 956f58d0204a3-67df44c2868mr3252522d50.82.1795471364202; Mon, 23 Nov 2026
 14:02:44 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-perf-symbol-memory-send-v8-0-370561cbb5a7@uber.com>
 <20261121-perf-symbol-memory-send-v8-4-370561cbb5a7@uber.com> <awOMG8xqEUl39vcW@google.com>
In-Reply-To: <awOMG8xqEUl39vcW@google.com>
From: Alireza Haghdoost <haghdoost@uber.com>
Date: Mon, 23 Nov 2026 14:02:26 -0800
X-Gm-Features: Aa3M54pc7Xydk8ofTh5z-KGnCz3jUEqSJZceW0b9awRn205kGZe7a87z8EONDZk
Message-ID: <CA+w=M=RewiYMRHjVX-y13tPShSz5cmCeMg5UZ-KU1JReq3n7XA@mail.gmail.com>
Subject: Re: [PATCH v8 4/7] perf symbols: Check the file before reading lazy
 symbol names
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,

On Sun, Nov 22, 2026 at 4:43 PM Namhyung Kim <namhyung@kernel.org> wrote:
> I think it's extremely rare that the symbol file is being modified while
> perf is running.

Agreed, and I think this patch is too much code for such a rare case.

> Is ctime really needed?  I think dev/inode will catch new file creation
> and mtime is for in-place modifications.

ctime only matters when a file is overwritten in place with its mtime
kept, as with `cp -p`. But I'd rather drop the whole check than tune
it, so I suggest this for v9:

 - Drop this patch and its tests.
 - Document that --lazy-load-symbols gives the same names as eager
   loading as long as the files are not changed while perf runs.
 - Keep showing "[unknown]" when the file cannot be opened or read.

I measured v8 with and without the check on seven workloads. The time
and memory were the same within noise, since the check only adds one
fstat() per lookup. So dropping it makes the series about 190 lines
smaller (plus about 390 lines of tests) and saves nothing.


Thanks,
Alireza
