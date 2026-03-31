Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885FE390223
	for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984601; cv=pass; b=C2Nj7VzquEmlRbzlmZeQN/kPM5cu+rL5/Y4NEuha6htrCU6gAQ0w5SI+pkcanGscMzyYxYEgWPkIhiaAkWa0onU0G+eAgJVQa2DoXKBGjvCaP8Hwq+Ya8We8x1+Z8Lytgj/zP3brJ0mEU9I7z8HeBSmOyWCio8UbnyJ6FLQsiWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984601; c=relaxed/simple;
	bh=cyZg60YT2Q+jv3oPbKNfrzLWm6pYCny7MZbgNJlXwNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgNcT0ZU4nYIoomtANLCx2K8lJ+YxC+EWOK3XH5VFpcu0zAyq+2O6/wP8yEhUpYWsaWj9uQMxQkH8ZIEQo+v2YtdVeCKvAswc4ZzArO0UMfp5RO/8NUsL5qv+XmZjXzGajlYFvSi4tiCYeyi8AUBT7/Y2EokaFMITNnM00rm94M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SPYbB5Nc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UAX+nsFR; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SPYbB5Nc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAX+nsFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774984599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uppfz5Qxxq0uGoccfZooH89GvQeQtePyZzyLR6lXc0I=;
	b=SPYbB5NctESmNye/Kpt3D6slr14zqy1EoP3Y3rOC52qUUWz1jsgPPCWDLIxMpSbCV/oO9p
	L7MIkVK250+nJo12TRE4Xw9u2wY5QA/6N3YXeoyM0rBJeL7P73NYMDreIm3rAsynRAHRYW
	fplXcP18M2478Mo7N/NUX1//Clra3eE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-RQhdI_czPLSSJFcwwSdPmQ-1; Tue, 31 Mar 2026 15:16:37 -0400
X-MC-Unique: RQhdI_czPLSSJFcwwSdPmQ-1
X-Mimecast-MFC-AGG-ID: RQhdI_czPLSSJFcwwSdPmQ_1774984596
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-38a2ad13c07so28325601fa.3
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 12:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774984596; cv=none;
        d=google.com; s=arc-20240605;
        b=iE1w3iG4snXMekPGprdZ1H+0iyi+aZBS8iEez8nc42xoSO8qAev4js8D9PVQTbNb8Y
         p2XGpg/lMaFC2V3ka+tyuIoHTl/Db0S63essyZJ9rCe/SMw8c2PjvmlM2TekEfSb6ugZ
         5uMKzrWmHG96Sn1UWXDiWjRx6Wb8tfpA2eT47q5ueLex5Rw08EHiJUdmdJlkFFTcCYEK
         e79oixlxYdcOEJLFG3yAhn8HbO4JwEKq/0dfDJSFBIvwFWBYx7WKUsMGIMjnUohrwJZt
         zkaSDnWevHrt2RPJYxHw07XAE+dzuVuCyEDNGVGELEUp4kNOXoxCmDN4qrYJfV9xzWMw
         Wnsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Uppfz5Qxxq0uGoccfZooH89GvQeQtePyZzyLR6lXc0I=;
        fh=zmAfi5cVf03bSNs5IgxZuKBpm7viuw+dUIp7DFIeuzo=;
        b=dOUQzhSk6VwGx/TvTR6Y2R0VvIvJEgXx+YMEFcmIJ6tt+hzf/pMiHDw3SpieKKbliA
         tJCe5AWYfQlq6x822tx3gPuvkHnS8xlR2kSVu7N//2G5IOO5tMM+M563NGX7Isn/UVPr
         OLOaJehy1CED/b1A3lo377WAZQb3RCISh/XOOGRiJlao4HtTslgGkKcCB8hYUSKRTNlM
         L0bGGnu3vJZKpMBBFob5sJ6XR46DzRccKMRVhtyj7ij2Dz/LFBJSEcJ1qj1V/XfiIYhN
         LUQ+8/8ToBhzbQKMP10QGHHBLHhuUPqKt3V5RQtzL2Tl4YMpbWcHNTb/na4JcDv6Srjl
         +wtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774984596; x=1775589396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uppfz5Qxxq0uGoccfZooH89GvQeQtePyZzyLR6lXc0I=;
        b=UAX+nsFRjqWYLAsQ7avrh2fUxwkyMJZET8LmzDnEijW5BMGO0z6AQVHe6NenOV86Qj
         8uLQyRvutmemtP0/bkcMkCEmLNiTvxWcFYZhHYKQPs3jS/jbqT5WT1Vo+tiwaEShJa5R
         c/aOw/TO0enqwNDPiu+9avmPdfw+KFixQt+HMQyOV//KG1XNmXP/+vr3gVyDVfaaAR6L
         JMxJVIwU5RBUA0vdK0HnSlU7aqYquNBVHPZWj5Qp5aWl1z10J2axHOvP0+T96kvU4mwl
         HtcIZ+hZIIy0Bradt98ps9F9ouc7nQ0WzmnbJtMDDCnuMBfuRyoDDMXhsYTnf4So6wSb
         6ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774984596; x=1775589396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uppfz5Qxxq0uGoccfZooH89GvQeQtePyZzyLR6lXc0I=;
        b=M5bj6KJZo20xkB1dvLp31H02GqbTsMQcJwkic0wbiE26qjZ9SHNctbbeyWTCrqXl0/
         omWPwX5LQkdWsergV6eioSut9v4/4ZNpsFjk/9NnBe440enlWN6B/gGGavv8In1VE1ac
         I4uM8N2iXzgf6WNtJUQjkEfLOOkY9De46RWTkj3AeVjJScUXl+JEHxmIAPrbN3EMTVb2
         y9KfDrOGY1SQZHmCirgamy67g+ALoWvtEqupS4PxQdWsxbKaNawzwFyvKoBxLzEK9VXF
         zXLBe8oQEaG5KJGID7zPvD8e/+GsjF79qhHA9bxzCPlUz11El7+Q53kB9dDxuKpTIr/Q
         V3hA==
X-Forwarded-Encrypted: i=1; AJvYcCWhXQWGQnYps4iuohi2ZgsBF/Y3k2mnM6P6IC3fk/4LWxkG7V3Kd+WElJNC7Rpylq1Y+fWTP4Zr8QA3KKsADpPu@vger.kernel.org
X-Gm-Message-State: AOJu0YzWg49U50+zLKlZ/SATZRagYmzvMLYzelZIahmEFdIILEOzaLWy
	XjADo6ljIj378nKWhRVoEGFkiFs+T8XKIbewxEwqG7cAvzREqDJo51p2QnyzMWsob5QtviSFrno
	wzODo2M+YpKGzWx6sZ/D8VVQNkNXM9ZgyWzq8e+ZQxVtdxjpFJGTBImTZ54e0nx5yKtha/objqU
	+SwCuYU7O7nZ1Vc1/5vjcrjgOaXLFCO6F6Ywq6uJ5gCssgf27hOzo9ItNt
X-Gm-Gg: ATEYQzxcCKWgP6XbEUla/ifEwxcIdv8UYDU5XmP05ArmhD8U4jeYNSP5MO0AGDkJkwV
	uTJsz6EQdyOt44jmn7aCKl9VvOeygAox9aWfZggl8kIEwwuX1Qt1Y6KaDYL9av8Aayv1ZMYlJ5J
	MjUqOJzVGJ01okazHlKQNZxL1xOopwbsq1turPmpsVoJl2OJd4RuthCKKeo+BruVyXKih/KrOk2
	i/t6EeaWp73mCH93Z2IUrGg/9E7CohbkzIsYLDn
X-Received: by 2002:a2e:800a:0:b0:38a:422d:b647 with SMTP id 38308e7fff4ca-38cc3093a77mr1083001fa.23.1774984595518;
        Tue, 31 Mar 2026 12:16:35 -0700 (PDT)
X-Received: by 2002:a2e:800a:0:b0:38a:422d:b647 with SMTP id
 38308e7fff4ca-38cc3093a77mr1082881fa.23.1774984595002; Tue, 31 Mar 2026
 12:16:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330194021.212912-2-ashelat@redhat.com> <CAP-5=fUvN=7ynEXju4jo6mWuajRRY0uC68SpUR8mTvXPqrgQTw@mail.gmail.com>
 <CA+G8Dh+rSWHuO4ihq3Qbf9=qBcjhZ_AWLZxBPh_cxJ=GDfvCRQ@mail.gmail.com> <CAP-5=fW=rMqV_ci5u9wvXUJq_1aiKxTSwi3MMYPM4XHGwUDSvg@mail.gmail.com>
In-Reply-To: <CAP-5=fW=rMqV_ci5u9wvXUJq_1aiKxTSwi3MMYPM4XHGwUDSvg@mail.gmail.com>
From: Anubhav Shelat <ashelat@redhat.com>
Date: Tue, 31 Mar 2026 15:16:23 -0400
X-Gm-Features: AQROBzB_m1fjIej6XUEeWQNSfdixGZb3H1gIsANwEJlmJ8O-_LfAYg4HhP1Pum0
Message-ID: <CA+G8Dh+nVeW7L7v2=pr3DDPEB4Q8Trg7YuJKUb846NFX+h6f2g@mail.gmail.com>
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

On Tue, Mar 31, 2026 at 12:22=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
> Thanks Anubhav! I think adding null checks on elements in the array
> could cause null checks everywhere. How about we keep:
> ```
>  int __dsos__add(struct dsos *dsos, struct dso *dso)
>  {
> +       if (!dso)
> +               return -EINVAL;
> ```
> and drop the others? This clarifies the invariant on the array clear,
> avoids bugs and eliminates the need for additional checks throughout
> the code.

Sure, sounds good!
Thanks,
Anubhav

