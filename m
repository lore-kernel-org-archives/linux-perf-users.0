Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4823A5E83
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 21:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907457; cv=pass; b=hTKh/oBnGKF8sE7Yp8QE/gqT6wvu2gXhpw/uKSX+SE79fIvr2yyXE08XlzqEypPIUF4Yjig2VmV5GUeJ6ypCJjI4/xlJQ+wrF9kWVAK4lDD45q/Sx2cqKdNWQRPc53O1Gpok/I9zTPnem4pqcFaFWIUCZLqphS3GBnBIQ9AMCzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907457; c=relaxed/simple;
	bh=16trTYqdUvfLnP2d1X3/FLgzLapCukA4O0Gg1kYU1SA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODU1zpOcOaNfiACPSGwwiMJmlBhZA8ng9tKFsYhQ+k8wV5tLMU0qXIl2AqmmRWbZYElYWz0RPVWVXS4DjS/FXDiPdBaivlZYqt8TEGSsVV33O44K3nwLJdJ3fbOoVwi8pfuU/4gZFdi4klxfLLzt8E1uD9jSxm1uHfSmHKyvDxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqCo0SjI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGG9eyMU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqCo0SjI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGG9eyMU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774907454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J2K6gZ+oFXq4qrYYN555dK1MgDnH2FbrbOyZZqYR5S4=;
	b=FqCo0SjIVxa4HC9NOdi3lkIam+vK/oSUhIsZhIgwB8hAZ8LylVLloMIeR12eQj4s3+0o58
	p/6Iwv/lLIg6ygH13xZFXPuqvbQlMuFykbOF8s8p+H2FyB0Gt9pj6yQLguxUfLWOFHS+I6
	RQqRQASsc8a9eRoQMSFdpKLavU0+Hbs=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-2Zn9fqK7Nte-PB1ABC1k-g-1; Mon, 30 Mar 2026 17:50:53 -0400
X-MC-Unique: 2Zn9fqK7Nte-PB1ABC1k-g-1
X-Mimecast-MFC-AGG-ID: 2Zn9fqK7Nte-PB1ABC1k-g_1774907452
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-38a326b8fa0so32226691fa.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Mar 2026 14:50:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774907452; cv=none;
        d=google.com; s=arc-20240605;
        b=cjMQKvh4GEhEJuc/mMME711i3xGewVT2A7qMZ8CYtCL0jRUmmOeMN+y1npThuXJAdy
         NoqEojAosgaSZtNfWgnSoTvDzP8jTPLl3AyzXzXUda60b9AjBBlcXjnCmsqMgSTnTPwm
         n/54BhYbSmrKSNaJAktaJp99kzhZEvqSBld7FoDnP0SxRfLCdE9dEYbdSmF91qbr91UM
         KE/qIY8R0w7FOwbL58F/sW7Lc06OJOIfF8QJn7mGxl98POLVGyG8kbiOGbTmhsJVepy7
         +2dCN/lh1p1eW+dGNCVJKj6lsAS9kW4kUYqPOCNZwBUbRD53XENujT7GpTznqLIMJEaP
         jYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J2K6gZ+oFXq4qrYYN555dK1MgDnH2FbrbOyZZqYR5S4=;
        fh=cqoLd1FUlo3XxYEN9jX7pqohI1iuYlQcvGrHNG/FvG8=;
        b=X6jHXesxC47WRh8jBlTM+S5mEgw8EufTteEfHdQf/l8qtec95Gj6/FwU4GyYjUxCfx
         zjD3NWPckgweZj4sWjclI2VrG/MZVUbJSv8WOV6CVYuZMTHfAEB5E8DK2XEHd6dMMVdI
         VSLVtpjMg/F8xhiyZIzI3CspMff5J26AEywXv3R0+/AjXJHoHXCNvpfNbblh8EQZqeAO
         Wf/D7GzfopLxKIRBn77vH1IbPXqlxR4cBdduO1x2SpiawtwNdPw/XVucLDPtEvyw7JPX
         VXVBsty0mFfratgJEeQTrBSR/97xPQ9B+ogmySKOINEoROu0uJnhxcC+1sxKG+nTDNxz
         23DQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774907452; x=1775512252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2K6gZ+oFXq4qrYYN555dK1MgDnH2FbrbOyZZqYR5S4=;
        b=bGG9eyMUKhafxhM+OKk/3kR1fiJNrIvLmt7pxlbDP2YrciP9OI1AciAXzaIg2lLnto
         SWvv+uksjKTYe8NwbPS21eKsgpsX/RP23h/78O+reKkUgq+flbPz/XC3Cl2RoYNAj9fo
         SIVLlt5UQQIB6LWWVkhhd01NUgAwVS6+156n+iTVMWplnnVa7TUDTIzuSAFic9laTTmb
         Ybypt/i4fyDyvfMofET7Jo91Nwc7hl/H9pWCGoGWu8Omb+hnseqnDYHzn/F50cUwYn9r
         e4YsTiKlNrc/EcBXIYdu+R2kad74P7ub6ug7LPRsQy25juAM8U/hqK9QGG5IWtoAA9Ly
         fuCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774907452; x=1775512252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J2K6gZ+oFXq4qrYYN555dK1MgDnH2FbrbOyZZqYR5S4=;
        b=hbiE7dR4ilhRB6YpgAJmLpnCdPHG8Ll2TnqlRjmaGj33Lr5p0nO5QlCeUbYSEsi6yh
         9aM4XzqQ0FjnoexKcwflripw0niNLvHmuoDQiNKd5tEnkFrkzWj9VPziGqEYTiJfmtFK
         xTMzGxG0VhhZRHcpOFn9VR9LGKJyROATuv/LmxJcjZXSaHWF2J7/91t0s3RPNuoGeSIr
         sCr+auaWS9k6m48xAsVTjxlt/FzKzNO1PkVl2JfiY7Ujzpplpw/0oszYUlSYiB/wWJPj
         8oTZznO3r1Fn9WZbPnpmWVwB1koNTvhOncn9JaW/LkNEsnmlpe/yLhVvX1l1tbnukeaU
         tZsg==
X-Forwarded-Encrypted: i=1; AJvYcCUPmQ/7g8sHIyA3gXa3ayNMw89iL9JZbAgApCz0K2WVy4GWlUNEppohct5D3lClGUFo1gZZYmBwDQQ2eYCYzbkJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg9FSjwIGDmXiB+Aatx692LL6rRCIzkojemNUIHPEx6liaKUxy
	+d71o0twQvBFWldb9kQDcCm80MU5km+Rq49N5FUMD+Ak+zrWFfn0pTjlzL7Rz4hL+F6nJUnsf00
	YTNmyeAkuSH5IPyrdABWPjyr/oLx0TvG0XjG5iXR0HFCIs825j6ihwAYvJKf4IkHwMmM7GGoI28
	vacfMnQznWO2KGKoMFb/tCqZT774tEdKI7JNGXJCUkKcMbNg==
X-Gm-Gg: ATEYQzz6PREjHzL6ePCfGNLENLFZo+cNaNDqokQ63Lz198t7jOK413MEF/8iKxUAc7Q
	z8350Y+JPVdRKeWIHXeUL6ly1x3ZzQXhNF0TFAwlYWvYZpIyagZFoQHa4BdjMOjO9Dky7JDo14o
	aqgVXUwxPDzELyCBTLFhmtruPoxLdq5Vr1aDSP7SdpKfQYNtJh7Qk7XLh+e+gZiKDhOsjBEtp/B
	PhzVt7sDst14FwveNHyUaygzbM+UIBRPVSDAtcZ
X-Received: by 2002:a05:651c:1144:b0:38a:31e8:c0c1 with SMTP id 38308e7fff4ca-38cb1ad9bcemr3483251fa.12.1774907451723;
        Mon, 30 Mar 2026 14:50:51 -0700 (PDT)
X-Received: by 2002:a05:651c:1144:b0:38a:31e8:c0c1 with SMTP id
 38308e7fff4ca-38cb1ad9bcemr3483111fa.12.1774907451168; Mon, 30 Mar 2026
 14:50:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330194021.212912-2-ashelat@redhat.com> <CAP-5=fUvN=7ynEXju4jo6mWuajRRY0uC68SpUR8mTvXPqrgQTw@mail.gmail.com>
In-Reply-To: <CAP-5=fUvN=7ynEXju4jo6mWuajRRY0uC68SpUR8mTvXPqrgQTw@mail.gmail.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Mon, 30 Mar 2026 17:50:40 -0400
X-Gm-Features: AQROBzCGqVSCTRDz6xA9cTMglaVz1brRpnlhGWwDwbaosqcgwCcwg9sTfvpcQaA
Message-ID: <CA+G8Dh+rSWHuO4ihq3Qbf9=qBcjhZ_AWLZxBPh_cxJ=GDfvCRQ@mail.gmail.com>
Subject: Re: [PATCH] perf dso: prevent null dsos from being added and add
 comparator checks
To: Ian Rogers <irogers@google.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 5:06=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Do you have a reproduction for this? The entries in the dsos array
> should never be null, so the check is redundant. If this is
> out-of-memory related the check in __dsos__add should suffice.

We don't have reproduction, but we got a coredump with the system
crashing in dsos__cmp_long_name_id_short_name. This is the stack trace
of the culprit thread:
Stack trace of thread 12717:

            #0  0x0000aaaad2905cb0 n/a (perf + 0x1e5cb0)

            #1  0x0000ffffa7090b38 msort_with_tmp.part.0 (libc.so.6 +
0x3eb38)

            #2  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
0x3e9f0)

            #3  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
0x3e9f0)

            #4  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
0x3e9f0)

            #5  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
0x3e9f0)

            #6  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
0x3e9f0)

            #7  0x0000ffffa70909f0 msort_with_tmp.part.0 (libc.so.6 +
0x3e9f0)

            #8  0x0000ffffa7090dc8 qsort_r (libc.so.6 + 0x3edc8)

            #9  0x0000aaaad2905e28 n/a (perf + 0x1e5e28)

            #10 0x0000aaaad2905eac n/a (perf + 0x1e5eac)

            #11 0x0000aaaad2906764 dsos__find (perf + 0x1e6764)

            #12 0x0000aaaad2928438 map__new (perf + 0x208438)

            #13 0x0000aaaad292765c machine__process_mmap2_event (perf
+ 0x20765c)

            #14 0x0000aaaad2973b94 perf_tool__process_synth_event
(perf + 0x253b94)

            #15 0x0000aaaad2974874 perf_event__synthesize_mmap_events
(perf + 0x254874)

            #16 0x0000aaaad2975200 n/a (perf + 0x255200)

            #17 0x0000aaaad2975428 n/a (perf + 0x255428)

            #18 0x0000aaaad2975504 n/a (perf + 0x255504)

            #19 0x0000ffffa70d2e00 start_thread (libc.so.6 + 0x80e00)

            #20 0x0000ffffa713d49c thread_start (libc.so.6 + 0xeb49c)

It looks out-of-memory related and I agree the comparator checks
aren't strictly necessary, but I think keeping them would be a good
redundancy against some future issue that would cause a similar crash.

Anubhav

