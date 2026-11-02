Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793642523;
	b=tjkCNd39NZ3sQSjEBPXoQUvS5cy+0Aew1LX6PtfOpw9v3zKgyxmLs7VPROTDoqH5ZbYo
	 a3zNroS15UVmOOGfkiN+lAaL0O9whjg9ocKbVQX/qFfKxaeSEsnOKSGOfaOQPklPNXmYC
	 R51KQgBXwtbYZ0fZysq993wrs1+MXHDADt1VF3h+i5yq6EAYSDWHai/+8kmh2CFJP0oYA
	 wwQCc1HD2BaVhxi4qoQr9TzPcfbqsTY5lBQ6wp03CCHqZgt+vQi3H1TxK72L8oghUEeec
	 yop3b6IwGpi0XgqccXG/9eX8embHXDVigyFPJB+xxrwcQem2dyOaWWw33LM9HavNNJg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642523;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zQVpUc6t5sX3lie5+dJjcoUcVnf4IiRYmAm/BtKdX/U=;
	b=uNORntJdLSw3jki0bloe8pvXAMej5cCre9AnMZZ3CFJhIpPPAjSl57eaIYIC2sTZD1z9
	 3waNV6thoeLXHnbKvaCTTbnw7V+5TaJcQfdyhcP2D9Lw3P6J46y4+yFgMWNkMr3p4qORR
	 fm4laBSsxBvjc4Is6TulwT83y6iMcYbEz0DnMJ8tjfiyS02JkJzEZuMbSln2zY7gHyM4g
	 5EyFyi/ewCJzPpvI24E5I/bhmbi8APVi42xN3rpmcroHbTHM4ZrOqe3OO2RRInYRocL1B
	 bLKA5ZM+cL7tMuQTqdlLuOeg3YnW46g8HOGtnL41HzUs+ulLXRUNoye9J4kK4FSdheQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QvbmQj0z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A126606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 18:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A126606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QvbmQj0z
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-535f598d126so492551cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 10:02:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793642522; cv=none;
        d=google.com; s=arc-20260327;
        b=UOgDVQ4aZW4S3OhrtPdlqZXiCP/0ZKh0Nt56Uwl+UIQri0QYhYz44t09MuSSKfsSNZ
         imuXPrDW0aQUROTXZYk+2rO4R1HOW/lSYbVd87TCfU2tV9DGUxaP/Qy0damUpozgQFKZ
         EdtowrfB9XoRNPOmsaOhyeIAM8goDW5vZ8z99V+oAGgQiKuKXZpTwO6n2ASEozEIaLZB
         JHnJtYRVH5m8SGmdoqL8mJ1qysebOHCkpHJYsJYKHjDxlej/TTBf7q04dk4t1PQygi07
         fb0I93CwJMkMamn8R1eyWVwvaF8u69aT8s4V1K5vh4vrSu/sRnz5TjLjGKdRyGSfvBek
         9RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zQVpUc6t5sX3lie5+dJjcoUcVnf4IiRYmAm/BtKdX/U=;
        fh=rcsQ6z16FdS1wxbKb3aCDRSXcNaL6uVOnxuJJe7lbrs=;
        b=XTOgQKLwLPWe1HgN4NwriQGHM2g441za6QbnfYJSKwVRlrukkiDfH/Dp601QPADcr0
         IJzS1HMRbAa9p3wBIdtarFI3qjKIk1DA9PmcRAn6qsHHaEAbrsGIRT0Clpoe2ZokyhzD
         4uwfDq99Hq2keoMlZOw2wknolDxcIQ5paTo+xMQsWOD6DaPH1HT8dpwDb4nkYOK9TqZe
         5Gis8EpNfzqQPNOZvViSJnhiT01+faHTndGQrjW/V3ScbgYbOaqlnLImJ5P6cJvb2+XU
         pjbysZ8011D1q6hnUxCUwNpwDPDUqK5cC+9RBjw8Qng2rfZsPk/McdyB0vRTU25pyxJv
         hGUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793642522; x=1794247322; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zQVpUc6t5sX3lie5+dJjcoUcVnf4IiRYmAm/BtKdX/U=;
        b=QvbmQj0z6L1le+6Qvx/RqdIAXnfDLesNwtVoiSJ/7LXE9J1zq5B0RrEcArAB3oflBl
         hOU4rI/TumzEAloN1odCQbBRzrLS2T7y7fwGH4KtKsrIORJtAdLka3UQiCaIFNLcb4d6
         peGRJppUCgMsNT04e95I1uapVS11JDS7irhCp1ccRQimWEAZcCzPMJlu+NhDTypMzxfn
         TGAHY9zwAbEOQIYJ5uHCsOneTyWF7i4eJxtrvQKQTKBGt7kjbatlEfX4oCq6+JowjrAR
         NnbBVUOa9O2yUec50autxECa/imz9+UD6nFnV8fjIJmmb+06tr3eGnDiO0TZfeWxwCbm
         W+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642522; x=1794247322;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zQVpUc6t5sX3lie5+dJjcoUcVnf4IiRYmAm/BtKdX/U=;
        b=WFUDMh929dbw6qtdeIDyK4jn3J/+kiuL15w1gQCYz4BM12nhAgaVpB8nctRuOr916D
         7ReJ14UwugJ1BF3KmrcbTa4MH7FRqaEbpYUC7PdfHxjPlTuzOm0aAAgTC89mBhIXSCiE
         6KKT0s4pdwo7wmTMIoyu1vW0iJqjES0AJaunY7NUFufj9LsTH2xOUBLiL6XggET4ajqq
         qnUtDi/M5QTq3ZoIHbZycNF2AvhEBBQdis4q6TkEr7biiCcvbE8V93A9GXzekgIf9iJi
         eaPocQrNLtjZTXnLEVkJTCC6oShOeNlFpyT+jsLtq9U7rgDyAQ9JOFaTx3BWo7IaI+7m
         knYQ==
X-Forwarded-Encrypted: i=1; AKwUvByzAd6Liq5UB5UzyFdb01iBXdaMYykWCotvdhiDgMvr6iXAZu41wj+pUOyZMre+mgMxymcKrYZHi0CmZk2gIfx2@vger.kernel.org
X-Gm-Message-State: APuU4Z+x9fUjXxoh1LHWWNwDSUPbq66PSqiEyMmT+DCfYAJ/vOCgZxyO
	klss8ZpEEQsjaFTNhEjsNShyKBrLWVF472ro/Cf6XkUGmPKR1YMORAKk/6khWWc9r9xum4qBDv5
	n7FnqTYqg3to0NH/7H5GgQseL7nGMkqwtX0bgHLfV
X-Gm-Gg: AYBFou3k5S2RNi4yT2K08DLfI8iub915JYtwzHzHvJ6IBHFT6fy3QP/TYr9bIDmsrKf
	HVrHujdbyqI8ZMCpXD9jDJjA4OL53JAd197n2W7N043YWoxWlgrU/bXunlAdq14uKJUnQDSnI/x
	6UmhYML1YWZjTA0C2+9CefncEtV0qPqfpq/jbPLT6S1Dz2FfxQ7cgyLKtbfHoEu5pVHZ3G7bWVr
	BKI//D66mTwJCnISHNOu+5uPUPxgVDX7iNaUWE736AceQZe5K9sk/jThwzNQku8X8iAX3SwncWf
	fJU2MMTiqQoMMZvBM/3FynnWlygcUv8D+2BulSXQfWc8cZ9V05dO/g/ujoyHOWOqDbtyLNEN/QY
	ByfdFi8uRJmPVLoq39Pa3nf2au3zxyZoC6dvrnw==
X-Received: by 2002:a05:622a:4a8e:b0:536:97c0:dcd0 with SMTP id
 d75a77b69052e-5412cc33acamr89708631cf.4.1793642521680; Mon, 02 Nov 2026
 10:02:01 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028183137.537812-1-colin.i.king@gmail.com> <71e154fe-0810-4292-a955-f0cbab2b7e96@linaro.org>
In-Reply-To: <71e154fe-0810-4292-a955-f0cbab2b7e96@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Nov 2026 10:01:50 -0800
X-Gm-Features: AclHuK_6VTP6biNXJIrrQGQQoebrT5vhbNV4kO_dw17paAXmuHsQGGvuUXwy-oE
Message-ID: <CAP-5=fVqUNoSQ72Hh5Zam3tyqooxpQ0+puAtTvr6omzmW3HZaQ@mail.gmail.com>
Subject: Re: [PATCH][next] perf cs-etm: Fix spelling mistake "should't" -> "shouldn't"
To: James Clark <james.clark@linaro.org>, Colin Ian King <colin.i.king@gmail.com>
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Garry <john.garry@linux.dev>, Will Deacon <will@kernel.org>, Mike Leach <mike.leach@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 2:52=E2=80=AFAM James Clark <james.clark@linaro.org>=
 wrote:
>
>
>
> On 28/10/2026 18:31, Colin Ian King wrote:
> > There is a spelling mistake in a pr_err error message. Fix it.
> >
> > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > ---
> >   tools/perf/util/cs-etm.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index bdcf94813129..65bce2450549 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -434,7 +434,7 @@ static int cs_etm__map_unformatted_trace_ids(struct=
 cs_etm_auxtrace *etm)
> >                       continue;
> >
> >               if (!intlist__empty(etmq->traceid_list)) {
> > -                     pr_err("CS_ETM: Unformatted queue should't have t=
race ID\n");
> > +                     pr_err("CS_ETM: Unformatted queue shouldn't have =
trace ID\n");
> >                       return -EINVAL;
> >               }
> >
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>

I was curious how this passed Sashiko's review. Did Sashiko flag the
spelling mistake but the fix was missed, or did Sashiko not flag it at
all?

Thanks!
Ian
