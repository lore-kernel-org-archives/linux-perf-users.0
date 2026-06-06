Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71121155757
	for <linux-perf-users@vger.kernel.org>; Sat,  6 Jun 2026 15:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780760871; cv=pass; b=OSIOW2Rss4yLFwmi9S2Urttyqzv5nZG6VyjerhhpSvcYAmPFP0ivM0Gfxozg4HAvcfLwZNEvPV5wbHC/h0yijd4jKqqHAYavXbMTBH35+F2JyB5pJQOw2L6IKsLSdDdYKMc3t4ttx+YF5J9AsQ2SHUfTrVGIH4Av1oTufG+uSsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780760871; c=relaxed/simple;
	bh=MW3WGw1hAZ4WHwSHFbq1gQsCf4IBu3shonuPv5aQqeY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rjR9mS38jEOb4nwR9a5ttM4wc3dp6KCSTo/Z2vGnQRoIWlB8MPhe+cebSl9G/YiRrlj9tBkPXH6po3Dmh17xrl5gfbCZ0dFaNejTIjsXxO7UvsXx6Y+vN0MI8d3hS6+OsaaHWvdbjbkj+AW5n/BAN/btUo6aoBX4FmSdsFxICyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTScJu61; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTScJu61"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2c0b1a48855so218475ad.0
        for <linux-perf-users@vger.kernel.org>; Sat, 06 Jun 2026 08:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780760870; cv=none;
        d=google.com; s=arc-20240605;
        b=eDrElVhv41kLWXN9+cgy01q0Dj4OyvJYD1vb+HyXq//jK0W09PPccOvWLuxZyrDUfq
         1BPMBUK7NOVnl2S3DeAPkaxYyWR+J+Yio6NpyzyvC1ETXGtkTh4J8riOzSYFAmsbvOs8
         /WEnG8pp+bkjAIvYO0PDmMvTWEkICngLvkI6bJZSdcIrq5YCyktCuCYWlZSMEdOFBA2z
         mwHAnrs8VatQxXVKXyzNFZCwQF3rkq/srOW1VCLLpdlnW6ooJ9Uj51gtb4m71VhXJ77T
         pVdyKEFQXF7cKeJ6pFoV+kWbjeAZLmrTvT/RqluyJS6IM/5/wFn8BD68oPe6Kddnr5mU
         oQ6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
        fh=FUwQ6CNTosQmPnSihgfJ9e3qzUbZE+/4cxyo6Kjg+l8=;
        b=j0NJUwcAQu19VXtyWRdWiBsmT/1TaF5KDk/6jN4d9lo1YwgIgavSMkClY0lxZ929/J
         mqQu2KXpWH9a0iKLtbQ5Y8W55pwrEuz1tBWRKsWHnUpeJ6+0ajN6zpDoKGn8LSqeyPv1
         w4z9kgvGeo9No6bIuMtQP7++3uavhcg+rUfQt766k1b8Riom7kQpFQga9HKlvTrkqhOp
         sVr+khiov8X4aQumF181R6mE2gzNbEm0ppq89XVBw7MKnoKVaHoKZ4yAfA9578PaZuIx
         1EkoZ6XbUZT5mK41T1usVvU6Fqzqp42orWEEKCNlLha7VKWvIBaglXeB1zqjXy9SESvt
         jznw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780760870; x=1781365670; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
        b=RTScJu61s5Mk5KUCmPuw/6EHPzuSlfBIU66sPABtFMePAKJuiW4z7CbawUoz88x+v7
         HaVfcCWSLm3KTFdQXZ1QSidlrJOMa67BAdiJadz30fZ8nNpqEAXXoi58lIXHjeVK8+vs
         qSy0qjP13kTFoHmzS/SaCQJSHZphMt0hrxzOcrMVZAak8IiGpb6iAlGrrtRp2iHzUQ9i
         wBRtaCwdNBxp0RfrU+UTaOcxw99AgZrDIsy+/e4IZ7Ma+gAuGB9Z/vp4LNnDjUz3N+0V
         w5FSTQJA0kAwe0/JVuGxeCALxjLzmgzRlNIJ/GNa6BDScSR+5X/8XuaUnoItJ1S1dl4j
         bWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780760870; x=1781365670;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5GJqqoNLqYQ4v0lJXutWeKyal4BUzmhJxcxqQU5UVJs=;
        b=I3RWQOo2AlbMISY2Ay5ioTSCb5lKS+BhCVi8lNeLTO8PeKyfMmnfcemk/wNc0PHx+3
         fdSTjNsHQcz6EYrQbHA53MCXOmTLtY82nvB4l40IosO3fgdZT8v3KBHAGSJBk5uwn8tZ
         hqP8fPNEMAYl/p4ek0ARPXLgDGeYMxtlJIezoupVi6vimlJnZ53Q6AwSo/assYODOYWj
         P+CHY1foeaq6LU1BbnpXYVumSsLBDJb1wtsAcGpnGLFAOxM9z0KbdSDSEQM+QcrDdR35
         uvo4KnPDpQHZnEcUp3F4qUXjaXZmbBn48BQBT0rQ9d1H+vBp3V4fQufWzH0iTHTOaaQI
         SZrw==
X-Forwarded-Encrypted: i=1; AFNElJ850ViAl9kVag3Yd4Twv/Uf8BKGdi4U45uLp8Afh3xt0UG2SJnZTFGApP6Hwj0poNm06kvB34gcxuDDir28RN1s@vger.kernel.org
X-Gm-Message-State: AOJu0YwSpYICSfc8itbnK9+qIisCkEuNuNDJEXrLAklQxap4RdB86aVT
	lMOieV9Q6v7wHxCPisHnrPb5w7ZhqrX+kZApxcqT2KqS/fwLp6MfNKAP0W97jTbNrIgNg19en3v
	dVujrzI2FtptQra5tl8K4JzrusLAeuIL0kNnhluB+
X-Gm-Gg: Acq92OF7O8QH6R0wso5G1jefg/6upnOvrPPtZuBeGiRoXyHgPnYeQKl9QQ90eMFmBG3
	wO8qJYEFneWMinGh6G1IgAuUIXrLPu0o7u7jxSHNk16nUYuHATeGT800McjaBNyd9Y+nXmnUCGq
	CKRDMRnkxSEqL7qBLrJARRELA0hanZKc0d01FjYde7VFGBytv6Fu4l9ZyUeP5VThSCix3L+n0fN
	khKiGE/9/eHeWk8eFdFQ6oSXj4lwMOmU12mscZoRGJaf50QJSKHUQe8V0hxnCU2NoaZU3nJ1o1r
	ctQE3+FGPeXrcZAK8fM=
X-Received: by 2002:a17:902:f708:b0:2c1:ee6e:be23 with SMTP id
 d9443c01a7336-2c1ee6ec5ebmr2669175ad.33.1780760869291; Sat, 06 Jun 2026
 08:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606121528.406919-2-tshah@linux.ibm.com>
In-Reply-To: <20260606121528.406919-2-tshah@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 6 Jun 2026 08:47:37 -0700
X-Gm-Features: AVVi8CerL-6KbYuo2zlnlU9te7dDWQC60u93ZneUxymer8R9JGeLarJSQShqAs0
Message-ID: <CAP-5=fUOUtbfXXtGdSYrg1SfuTryNqFPknKWDc=4MxK==m6+VQ@mail.gmail.com>
Subject: Re: [PATCH] perf data convert json: Fix addr_location leak on
 time-filtered samples
To: Tanushree Shah <tshah@linux.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	vmolnaro@redhat.com, mpetlan@redhat.com, tmricht@linux.ibm.com, 
	maddy@linux.ibm.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, atrajeev@linux.ibm.com, hbathini@linux.ibm.com, 
	Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 6, 2026 at 5:20=E2=80=AFAM Tanushree Shah <tshah@linux.ibm.com>=
 wrote:
>
> When samples are skipped due to time filtering in process_sample_event(),
> the early return path bypasses addr_location__exit(), causing memory leak=
s
> of thread, map, and maps references acquired by machine__resolve().
>
> These references must be released through addr_location__exit() before
> returning.
>
> Fixes: 8e746e95c3e4 ("perf data: Allow filtering conversion by time range=
")
> Signed-off-by: Tanushree Shah <tshah@linux.ibm.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/data-convert-json.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-c=
onvert-json.c
> index d526c91312ed..6a8d00c80394 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -177,6 +177,7 @@ static int process_sample_event(const struct perf_too=
l *tool,
>
>         if (perf_time__ranges_skip_sample(c->ptime_range, c->range_num, s=
ample->time)) {
>                 ++c->skipped;
> +               addr_location__exit(&al);
>                 return 0;
>         }
>
> --
> 2.47.3
>
