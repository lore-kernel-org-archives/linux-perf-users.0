Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F273214A74
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 07:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409192; cv=none; b=DIDtpxe6PutacNdLJRdGn7m0LtQo6XWqGKzJVGe4oFIclvY4ArfoIRYiKVnrJroNAomZQFA0QKN7vi8JAjyWdi7IJkmaTVLQHXR7DKzHAQLm0lDYEgbA5+ZlUN2vfYxDDnI9TUYCBWeTZ+Y1QSu5xMlhXILitsq8HLS82Ar1TsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409192; c=relaxed/simple;
	bh=GKA/s0dhS3y5Q0wClnwz/vinA1zILLOoLzSvzMb3AiA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fluk/vDexkl/vGGfWruZKzcxMsbBF1w51YIYfSdvvZfgFQN5+baGiXs7rQbWReg8CbRoWY1LoQSZ7mcC8wm6xKDddSNV4YjwP/Vi+srMeWrqyYfgh2Ep+LJ3Fjzxc3T2hr+yegsfSTEUNWy3MPQn9vgaB0QIjNY4FUwK56XHdMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZmWc2eGH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZmWc2eGH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736409189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gfO+r5xR4PUDrsRJu5n76LpjO4EViTJFVCpyoVSyyzU=;
	b=ZmWc2eGHgxH3osGY6b553wU9MaSz+DnsDjJchQYhO7egM3yUhOxF8LhH04qvXd6EN+p8Gx
	BM7jRoOC03Pp0mf9s1QhXBE/eM3N28O13quwIIumi2I9Pjv34sro2agUAgmY+SdnV0zU8v
	yvOcYSJYy57lmc8951WGzSyNTUtV4u8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-aFitqN_6PvOidXyoENW6eA-1; Thu, 09 Jan 2025 02:53:07 -0500
X-MC-Unique: aFitqN_6PvOidXyoENW6eA-1
X-Mimecast-MFC-AGG-ID: aFitqN_6PvOidXyoENW6eA
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7b6e5c9ef38so99782985a.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Jan 2025 23:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736409187; x=1737013987;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfO+r5xR4PUDrsRJu5n76LpjO4EViTJFVCpyoVSyyzU=;
        b=Tf0hsbbe64PcjBKU/GnruRZPGdIMzfyyMgtaugXstka0uJzeJnQ/5/yByyncRqOXOm
         lttjaOQsXw52hedzTZrmDI3/M7rA53KoOxPWzdtQ7lxT5dW/IPBkQKBA40B/R/50r0wV
         DANiDp4pUzLCg/YuRMHOuzvfKd7rdAC9APw1bNBYh+5hPFUlw9Vg8P2mw+0oJ6Dnvhg+
         AK9aSzQBm53MR6QvMd/FrCtNUtWNK+TtYpWslalyScwwUWWHObT6843gMdv/6qheww0v
         6XXwmoim20NyCDrDnHPpM12yhq+xgI33eqMgxnPeLnfe/YXGxm1CNIUwEYPmShdf2UZk
         9M3A==
X-Forwarded-Encrypted: i=1; AJvYcCXiG5XzcUY8uQHJUZP0Lr9gUI/3fkP3X4hn5f/wukzVtzfTLoVhatvyIYdWtzcuVw5eOOPjDCODkmWygX5CJDxo@vger.kernel.org
X-Gm-Message-State: AOJu0YzUAW0xCp1sxkVHPQvrQys72XEZyQD6mFk2dtVtvrGQFN4wHbjc
	sxzQuZJ9PO9CnnTaN+NeXxFva0nS/fY5Aq8Nq+cI0klLg82CxLmicZRbpRRjb1pyEKXRqdHI5wI
	Bay58OkOsSWdHgxQtraMiOoTA29c50LN+TMzdRzU/5h9GKQF5ikMgO2IzPNLGxyQy4SM=
X-Gm-Gg: ASbGncvAxxOWebxd58EiihzWnh0Gge3LSGHzJqI9LZmFwF9Iot1+OF26foBN9zUtSBk
	9x4rnySXuvzG+hD9BcbLUofSSmWYKzu6qDctAb7M2EUSgWNwld4Cp2bDZ/iGC8+wQUwNa7Pskxp
	N9BWWZ3VT6IxcOt+6upR93LiA1MgIx3AxCdoQEfvDVK+7WPjNW4eJJaXysW+Uiq+4PXGzAjuZf/
	Ep0l/j2mzjvd3mSs2lLZARmNKHfyYx5D5M3Y+CnRHPgBRpPgyUVmAUEqC+jNrVZJLQ0PcT8zM1L
	zQ0PdhU=
X-Received: by 2002:a05:620a:248d:b0:7a9:abdf:f517 with SMTP id af79cd13be357-7bce1286ea9mr359755385a.25.1736409187076;
        Wed, 08 Jan 2025 23:53:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEEiUGlJ10Kc8Mh22kcaQUJV1JNv8LIMdR5nsQVb0+EmtKA1fprNXE6lw3tD9o0QflpgqiqA==
X-Received: by 2002:a05:620a:248d:b0:7a9:abdf:f517 with SMTP id af79cd13be357-7bce1286ea9mr359753885a.25.1736409186814;
        Wed, 08 Jan 2025 23:53:06 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.30])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7bce3248514sm42623685a.28.2025.01.08.23.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 23:53:06 -0800 (PST)
Message-ID: <a016ab208eb3ee3821ab59a2520a2bf56645917e.camel@redhat.com>
Subject: Re: [PATCH 1/2] perf ftrace: Check min/max latency only with bucket
 range
From: Gabriele Monaco <gmonaco@redhat.com>
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo
	 <acme@kernel.org>, Ian Rogers <irogers@google.com>, Kan Liang
	 <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, LKML
 <linux-kernel@vger.kernel.org>, 	linux-perf-users@vger.kernel.org
Date: Thu, 09 Jan 2025 08:53:02 +0100
In-Reply-To: <20250108210015.1188531-1-namhyung@kernel.org>
References: <20250108210015.1188531-1-namhyung@kernel.org>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-01-08 at 13:00 -0800, Namhyung Kim wrote:
> It's an optional feature and remains 0 when bucket range is not
> given.
> And it makes the histogram goes to the last entry always because any
> latency (num) is greater than or equal to 0.

Thanks Namhyung for fixing this, something definitely slipped while
testing..

I confirm your patches work well also when the bucket range is provided but=
 the
min latency isn't.

I'm wondering if it would be cleaner to propagate your changes (using
min/max latency only if bucket_range is provided) also to
make_histogram. That function currently works since we assume
min_latency to be always 0, which is the case but probably not
considering it altogether would look a bit better and prevent some
headache in the future.

---
 tools/perf/builtin-ftrace.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 076c703e5c334..82d63d7af9d03 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -779,19 +779,16 @@ static void make_histogram(struct perf_ftrace *ftrace=
, int buckets[],
 		if (ftrace->use_nsec)
 			num *=3D 1000;
=20
-		i =3D 0;
-		if (num < min_latency)
-			goto do_inc;
-
-		num -=3D min_latency;
-
 		if (!ftrace->bucket_range) {
 			i =3D log2(num);
 			if (i < 0)
 				i =3D 0;
 		} else {
-			// Less than 1 unit (ms or ns), or, in the future,
-			// than the min latency desired.
+			i =3D 0;
+			if (num < min_latency)
+				goto do_inc;
+
+			num -=3D min_latency;
 			if (num > 0) // 1st entry: [ 1 unit .. bucket_range units ]
 				i =3D num / ftrace->bucket_range + 1;
 			if (num >=3D max_latency - min_latency)

base-commit: 257ccfaf9fbef6f54eabf1a8f8a8efcc9036439b
--=20
2.47.1

