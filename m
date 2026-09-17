Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913C14F93D5
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667917; cv=pass; b=oMkHBHUh9OQzfaDyjJ/mMo2MScREHGL/ZKt8qP7LqIUc9IKhiOo3Q3coAJd0w7VjSmtxOdTXQmnAk6y4xbbSCl0Onh4cl9hI2O5W988cuSaWbG/A+DfaQwwBRAmP+4NntEY5iAL2UWOUmhggJmruc+hIew4obWXMP/U1W85guJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667917; c=relaxed/simple;
	bh=l+PocN5637M3qEv3P3iBxpViv1nZB+zPWLXTvof1XcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGkzWXxaCxTCWKo4p4IhGzxDUtbQ3ough+j1XvdeuhAg13nShCdDZQ/UjUh/RKxdyx98uIT+sQjRHd5X7wtCIPmFFCQd0dI+9FhtLZLs76ojbjTVLPslPozpm7RyP6oDc4uaxdRN+4Pp5iHQtiJlvkFvyPVp4Af/qH3lTBc7UPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b7lHyWBO; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7lHyWBO"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-53113d72966so30281cf.1
        for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 10:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789667914; cv=none;
        d=google.com; s=arc-20260327;
        b=LTxdiWpuK7MQG1Y2+zVVJAfxAYyIMZ9j4hurcKw8Mxl8hCPGgEVRUM0LdzK/ethcLj
         geOcTcWqrvVO/NaMlrYAytRmMF024+T1WbliN1soXix9LQqaGrwtm7xNWbzNqttM+VA6
         Y+zt/d33s/bomoUC0O8gZdzMkQSZHQDGcE4Bc7tuMpQgWnciEEcw+PnCykPf2acaYeur
         3sJsQeKkJR4QVUJARmMKhK6ydPfqJsIEAKFooYtHJk+MaFo5vMhTHJVpDBEBCmA/z6vu
         LMwgRy3T4JAcmLmHXtCPvSTayhH5QuoFlbwWWFoh9EnC0kaRB7+IIeT/Z+RaoPEHzcxC
         2s9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zH1jP0g6rTZl7HFb520QhPTGTp2IGGyzoCj2sKE0ORQ=;
        fh=1ebZxkuXkqffr4Roq2b2M463GF11ndgJLzkikGgWggM=;
        b=VQQEoK8Toxhc6UiTNof423CJEC0LvafYm6AwlKE4fBuRpEifxg4f+0/AQ+luOBOnnh
         sq/5DfykP4agP4ZyU4XQVdp4GYzaLT57uj8w7WwVAisvMcVw3RrEP0hWpOSSEZSniZf3
         iIgq5yBIvHIIL1bqRX1k3sSI8EDqt5yLIhzedS+kZYfYd9E9bQJ6aPbpvMAtSY6oWS6j
         hQogeIfb0hIavj2niE0gxFnhQYMaWtNQcZ44pgDg5FX9onBurwUv/hs771oF1f+NFRu9
         xoPvZJgF8Kw99JULEFrJakrIgERWW6M1tz7eFpq+OOhYNy09IfbM/eizJpSPWpSzzHxI
         G98A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789667914; x=1790272714; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zH1jP0g6rTZl7HFb520QhPTGTp2IGGyzoCj2sKE0ORQ=;
        b=b7lHyWBOZ1rBFdKSrdjN2HQkOv9o6Mkah8cmBvk9GJzJz+eU/92kIDWJBwhfCfOQ3p
         bXa33xO95fKHh1XySzMRcdFDrbbOfbRzBO30v9k87/4wog4ycTmIPhVE9pNAXOPfZgG9
         yNK2nojOIYOMPWv0rUwLyls0YujagnmHNsjr5SgF3xg/VQ9fq7GrH0vb80AjrM0DwoUb
         skhYS+rlrBi8HrAEawsCNFxpCVi0vkcUc6wy0JMiNplNDqCFDnUZGRgRVTB04d2aeBLy
         uPQ6tFmGri6gOmsyADOywtc08dOFuK70le392aDqdyRWtG+HCwnkXzyuHQ/bm7JpdL2n
         D/EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667914; x=1790272714;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zH1jP0g6rTZl7HFb520QhPTGTp2IGGyzoCj2sKE0ORQ=;
        b=M3Gzu4Rq1uiN/EOOYvcB3gfjhpfkG0sS0YMyz8qE70ThoOVL5/e2zU1LVkETggO02E
         XZahHm2lDWeRk4fDVl964YBOtH1B+kzmwP0m97/tTr+rhYHHLzDn6WshPlmGnDZg3+x7
         IAy6ekqGeHwy++RBj8zb9weMSVBtxP0GZ7M8RVdw+Cl+SgGSANK3bOXc82WUxwcRbkZ4
         wULBz83sDYyfmP8WU2dqPlGgfppNBTvqS9W3WEl7MZuamX8rzTMJKHPjpYqkhC1PzucB
         kNtelZuyO/qovKtt5H+SEsi1HTnz6OBnF1jCc6t8EqB3Jlgo3Uzh83pEg+hCWRnvU5hk
         pxng==
X-Forwarded-Encrypted: i=1; AKwUvBwLj7owTieuXtAuPi5N0mkdHqPLli9+9WUiZuog1OV4M+PZM0OYMBBuMCGiDpcR/etbgBV8Dcw0bXhNxtKrD/01@vger.kernel.org
X-Gm-Message-State: AFuF++kR4l7Js2ZnuLf7hqXZuy3BIT48cg7vjfSvg5KocYA+tqbcPL0Q
	qHTYYK4I2Hn3UMGzVmXI/fRYU6T+xs8T8IN0DZrxSM2mhLzSSyXdooP2bqT9nb1pyRbs5zMP7+K
	sbaVcXejwa75bdD2+Nabmdjd7uKW/V0mg7y8O6e6X
X-Gm-Gg: AYBFou3Ykwc1U8A89tWRNKxJOTtD73ASG5GDP5HNIAejl0E2RSlI2lP7K+TDcAc41cu
	+s1rJd7+27hgB89zatQYQbB86VckRoXXWHxvutKwh9l55RWN57ReGG13Jx6OPf2GI7rVrvWaw6G
	iYm9JJPqTz1FWdDeursSOwPoC4Fmu9HjGiV9A4Ic7vA8GblW7AMe7yUBVeYUPiMbssQigzhjg9H
	/UNesdpe9uogQZ7UNeftKOAwBC5jixFc9fBS4x1T4aLU6ZWKYexvwunvvC4nrkfI4iR0Qg2EYzT
	pF6AfmDmlNmBkUGrv7Od8JFJZBaBgXcuy0RwjxdN/u/4neeKZmmzPT3ZhrtSscuTe4ztWVRle/x
	2gqXss839
X-Received: by 2002:a05:622a:e111:10b0:530:ac23:ff40 with SMTP id
 d75a77b69052e-5329d84d69emr874811cf.5.1789667907464; Thu, 17 Sep 2026
 10:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917155528.62607-1-acme@kernel.org> <20260917155528.62607-2-acme@kernel.org>
In-Reply-To: <20260917155528.62607-2-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 17 Sep 2026 10:58:15 -0700
X-Gm-Features: AcwNN1Vxnw54th8UHPKp5uTzWVtQcuNf7uY8my8GErrk-09F_GrhQCeHOeOoHhw
Message-ID: <CAP-5=fX5+7K_9eApj-t87iFVSbUPZDpgnMYWfSoCcDynrYqixA@mail.gmail.com>
Subject: Re: [PATCH 01/15] perf debuginfo: Fetch debuginfo keyed by build ID
 using debuginfod
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 8:55=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:

[snip]

> +/*
> + * The build IDs already fetched in this session, and the path of the fi=
le
> + * that came back for each, so that the repeated requests for the same b=
uild
> + * ID, dso__debuginfo() is called per symbol annotated, are answered wit=
h a
> + * strdup() instead of another client: the file is in the debuginfod cli=
ent
> + * cache already and its path checked before being handed out, in case t=
hat
> + * cache is cleaned from under us.
> + *
> + * Guarded by debuginfod__fetch_lock.  Only a fetch that brought a file =
back
> + * gets an entry: one that didn't is recorded in debuginfod__misses as a=
 miss,
> + * and that is what keeps the rest of the session from asking for it aga=
in.
> + * Like debuginfod__misses this grows with the number of build IDs in th=
e
> + * workload, one small entry each, and is not trimmed.
> + */
> +struct debuginfo_lookup {
> +       struct list_head         node;
> +       struct build_id          bid;
> +       char                    *path;
> +};
> +
> +static LIST_HEAD(debuginfo_lookups);

I'd still prefer keeping the debuginfos owned by the DSOs rather than
having debuginfo use a global cache of debuginfos - I expect the
debuginfos to have some non-trivial memory overhead. With the
debuginfo in the DSO, when/if the DSO goes away we can reclaim all the
memory without worrying about a separate global data structure. We can
find DSOs in multiple ways with dsos__findnew_id:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/dsos.c#n343
We match by name, but if those differ:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/dsos.c#n117
We match by inode and/or build ID:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/dso.c#n1473

So struct dsos is a build ID indexed store of DSOs and their owned
debuginfo. We find DSOs off a machine, but I believe we always have
access to the relevant struct machine. In the worst case for probes,
for example, we need to set up a host machine. Using machines
inherently provides some lock sharding, and they also have the ability
to reclaim memory.

Thanks,
Ian
