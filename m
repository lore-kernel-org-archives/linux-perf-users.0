Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634F51BC08F
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348047; cv=pass; b=SY4SjU1wKM0IlckUcdJRx1tOiJsDEiV4+zA9nVKhNN6Hc4aYeNHIWuWx34c0L9qj4/vPFxbFPh1+Bcb0PBhVMhA8qqfTgSimKXxymwofvtWUjc768o0Que9TMSUgP/4qFlWm7NrZo5Zf/04hjfl4QMoj8glw2DlDhtOLv7uukz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348047; c=relaxed/simple;
	bh=AbZBPD4klOdT15F7xq22LLumZlQPiyJ1Uv3qouZMe2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e1X1+Y7C0DaKAFECCSxYNtaKIlla0qlfVLYrhwUJ6Ume4z8OgU1MRePtOb8MWOdhXHtDhfGDI1XKnuDOzHkNyUUvtK3BxRS33Fe62CXc0B2PM4ZiWrc0ni2HQih9LSF8rx/0rXolUP8sYebC5oNFZ/i9wqJztTUaIg+iAJxQp+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fc4D25pi; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fc4D25pi"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a0d06cfa93so14705ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Jan 2026 15:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768348046; cv=none;
        d=google.com; s=arc-20240605;
        b=hhZdCBZCP+R4WSTw/o4SU4i07M/YGwSv6DRbAT2NZmSoI3V182s0gc5nPE5GOMUD+4
         iI2G0KkmzbwznOl22ylAkcf92KiLUK6jEmNwpdMfzrkz+YmsWuv+2VJpHwnmIq3y+F5R
         sI1gwagLJmVDn07H8IQF7QdfFORASHL6+ATXciSkFdg/ju4ABx3VtvTBhZ2M3tJfzxWU
         nZ+nxMlvYeGXsScIIXsyo/lFKwc2A6BLdYJ0vFU5gWoWX6+BSW9UzK7BxzuAVqk2s6CX
         Rt1WpBA0iQepCRVy7e8Jzbswc85BFctnzGq06+tMzipHSC5JUzUVmOfXAJTaLkrLZ6os
         HbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EbZeo2umDmSceJCOaq+/j8Lj7CmFrxvgi6AVv7+a/TU=;
        fh=44vc8w1VKuVOvmo8cCb4gGkxoG7ySTiN8Oxwqpcs61U=;
        b=MD4cH4HzZOx7ulwG0J7YX2Ju8jdlGef70EKRPtL7WBi/7YOTfKG4C5i30nCKPxtLZF
         z4j0BldS1v4b6UV3J4No09/fQsc3pmZDRPrtH+hv5k77hJ/HfC9opoxzR+ue8yOmQrYG
         xLasyy45bX2AsJ8L8Ymg4tB/69SHAPiIdjsJG3uK9M2nHBNxHNSTEwK5JX8K/TL+c5uH
         AyvkjkIXBQRWLweyzXQdr5oT+A9cJ1NxBc9CiKhC2vyk2aNfLS4zxaPrgGvbBBAWW14D
         GIw7m/8sZ6OZgOIrgaBQOyA7NkVBofmfxqQIj51XY26rimzUytzpA9Y/EgF1Av88/GSq
         fD5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768348046; x=1768952846; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EbZeo2umDmSceJCOaq+/j8Lj7CmFrxvgi6AVv7+a/TU=;
        b=Fc4D25piVcymQ32kd7mABe2zuGRKTnM3P1tUSaFrXpQ1lOzSLy+aN3YNM7G+9J6EZl
         0nvXCOoVzPNtStiPoQdEsqOgo30U6pGr/DU/CPt8CT1+JWXQdkEJxzxoV5Heggrw9Gxp
         R+jF10u+SeIAUZgQFzH54/ru/Vj8kOaeudRpfgktZbFrFgVC+d6OXzxzIyw+S1CPzO4m
         qrZ7U8Jqy0lyhhS2V/n2t20/wJQLVxyOg8ELdOlJKFbNOJHOWZWsot2c73IvHfl5M0II
         KBTDuOCw+5PC8RR5IVGWAZuuCPfZO4foeGEjySkUXdqZJZdUiz4FmwtdCQrjhyk1Uul+
         5ewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768348046; x=1768952846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbZeo2umDmSceJCOaq+/j8Lj7CmFrxvgi6AVv7+a/TU=;
        b=RcSy8jYj3FbjASTDXeBKB6mRBhYG6ITwRXRbTnur2IWjlfTiuXKNHSiXSj5tPOXSWN
         2B0Gt659TX5BBabpjD4+sR38BQXgN3e5LB7cbxVH5ut78LNbOEIJtv5P4Ljwc7eAozXc
         I01/E43EnLlKDZqLSFhCMDQMNBINk+pYxIUlF1GTv9pKg1Ps6eqc4pzKsPbesbumShwq
         Ioiwhh6Oln62vdAHlHUdk+UJafKjtGRUn9QBu/8xaDggCzIscQPFczJWQ5wDq2DgWnHj
         onP8NbJJe8fzrkaWUkkooDPjH0F98D4XpS+cuBxq2I1lz/T42vFPw3Qw4zCLEbWvagy/
         7chw==
X-Forwarded-Encrypted: i=1; AJvYcCWvNA4lCTZ7vmOOh+8dYLEFY4sB4BwD+Dicpra+hveoAG6e9ulJW8GN9FgFfUgylHl/C1DdoiEK9evBJHSydtjR@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6UcoGH6R5j32tHqO8ZSe0mAqgrAJsJ+xGFNVUc7tccKo0PWX
	XaVbi+hwRjFPN7KlvDcrzAbkOjIdIZiCaIMHFqYIvdPYo3Jn7LTGB/f7axVHkeuFZ2AkgTHLj3G
	ugGMHx3Bx3ZKpDfShV3vbRexrCl5dxUQKikWvOoJa
X-Gm-Gg: AY/fxX5xXJoAZk7oqp5AW+9dzFAyB6X8q66wDGGxgREYDjr+z9jEIj89yzutgN00xpp
	Vcu66Tsmfe6GYsT322S8cwrCd44n3DmbBZAc5+OhAEir4C+f3fPzoVYOuUl8AQrI2Nc403dL1Gn
	YRqgli8SAbsjCX0ChW8+jwIiWQCcN+N6c/4zaV+rtnJoxLmNmxQpZEqVo6B8LYl5ubz+pX4zdGD
	u+zOdKKJWtmrSdtmCHJkLXMdwbIivNJ9nAWHfmbTrDURkXrF9aP7dlu2NtcGDlxacOij18sTrfK
	XCWGpTaZjDkZ/OIRZS9q4jhXKrhqmmYjlolo
X-Received: by 2002:a17:902:ea0f:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-2a599a38323mr1431055ad.6.1768348045526; Tue, 13 Jan 2026
 15:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com> <dbdd0541-0a67-4d61-9ae2-7820920e8f7a@linaro.org>
 <CAP-5=fWWHHioXCsZhxL=ooEPD_qZyd78t0Qjj1ieZYSB-Z_fsg@mail.gmail.com>
 <CAP-5=fVm8NfxyQcEEpKqLeXEGhzzruNFY=sBXGFzyiftQCPWPA@mail.gmail.com> <9f1182a6-fac7-41b0-b6db-24ff64afa8b2@linaro.org>
In-Reply-To: <9f1182a6-fac7-41b0-b6db-24ff64afa8b2@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Jan 2026 15:47:13 -0800
X-Gm-Features: AZwV_QgYATW02nbxvN-cNFcwHhmtrUDVLek3rbbbEbaMgn9_oPIfh4KzysoYeCk
Message-ID: <CAP-5=fWh5=AWq_Mav7B9nsuZ0TS2qPMMAwYhQKpt_BYFJRnf2w@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] perf: Add a libdw addr2line implementation
To: James Clark <james.clark@linaro.org>
Cc: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks Arnaldo for landing the series in perf-tools-next!

James mentioned frame pointer unwinding lacking inlines. I had a look
at and I think this patch may suffice (although on some quick testing
I wasn't able to get inlines other than at the leaf):
```
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2090,6 +2090,8 @@ struct iterations {
       u64 cycles;
};

+static int append_inlines(struct callchain_cursor *cursor, struct
map_symbol *ms, u64 ip);
+
static int add_callchain_ip(struct thread *thread,
                           struct callchain_cursor *cursor,
                           struct symbol **parent,
@@ -2170,6 +2172,10 @@ static int add_callchain_ip(struct thread *thread,
       ms.maps = maps__get(al.maps);
       ms.map = map__get(al.map);
       ms.sym = al.sym;
+
+       if (append_inlines(cursor, &ms, ip) == 0)
+               goto out;
+
       srcline = callchain_srcline(&ms, al.addr);
       err = callchain_cursor_append(cursor, ip, &ms,
                                     branch, flags, nr_loop_iter,
```

Having inline information seems like a good thing regardless of the
stack trace format, so it'd be nice to move a patch like this forward.

Thanks,
Ian
