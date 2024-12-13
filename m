Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6A18D649
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 20:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123491; cv=none; b=mBqPcy7VEFv30tjej5TK+tZ8iic33bF6pdC1gaPb5JP71qz4At5Br1wBgTp607wbB839jwYpdkLwaBuhHMo+gAqdd/KT/fWiF7euDte7N+sJRwwMl+MtjPMx3FyLBkgA93V3yYvjTl3pVdFK321uSx3EOt6oL0FeIGqZAzwRCWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123491; c=relaxed/simple;
	bh=AMFyDa2waJbDtQEqF+pSjIPS4HLmTfo1/bF558eIdmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVcqoRYenDNQm5hYYQFjf1K102gsbkpO+3xuE2yGE2Kgx6H0BfftXcoCILdRYzk7iiQaYXDnhcJwnlcF7pYeHrXNRFqQZXs37RztHVKuNoXqZSDtHprMJdSE+zVqI+fMLgif2vipgUka4Ftv7q88mqL+ILRXsoMncLwNj6FR2yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P87UrOQW; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P87UrOQW"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a814c54742so1695ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 12:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734123488; x=1734728288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5IPebKZoDc4cq9RTO8NfPXE4gbH6+uaL4YtlB4CSwj0=;
        b=P87UrOQWns11tHNT3QYfL2kce7eVQ8rOxD4r6O472KY10AK8sYRiq8zAVinhnOmDud
         q3Wmp/cBkbt1t6UdPEQvdO003+e6Qc26qBA9WTCAG6Wp9DlpNoAbvPbJHUeSi85iDCFr
         BxSgxN75zHuWtrv8XcE7MKTMlRpMNwAXLJZWXZJY7oxmWTZTeZ259KXhjXtS8x830pRt
         sWA8Z5VfWH9e4hhwLl+kcDbXqGE3CAtg3cTRlvMQx19+jJcawBeZctcjQdAlozTpVkOh
         r8f2oMLLNoJpS5zSt6Vf8ZNoI6hG3cwTsFK3IPaU2GkwGqNuBFbW2luBWzCnPyQHBueV
         LraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734123488; x=1734728288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5IPebKZoDc4cq9RTO8NfPXE4gbH6+uaL4YtlB4CSwj0=;
        b=pIW0m/WFgzpprS4TINSXWcmPlmP5NpXM3U1s+TK2ke7EcZqKRVJwD/H1RQUoEqWAMe
         uHLrOvd0IKkRAabZa7G7wujPPGsvm4YDCqcVT96mU9bBn80NkIhtEiuoWC8aAVTD0bZ+
         /RJJ8eoY/XfCiE8OU7WqjEiev0oB30Y4lkJ/f2tZnMjoMGTc9m8TIkd8hXUIWLapdRVs
         wLU+1LbhUtUdfKI/2gRXwLWcbTbDMZgdkt9bRoAWw7PHEJF8xx7t21/YuKmrbRjJmcV5
         Skb/nTcjt+tHrzFn/HZS+CH5JiKdX9y8Ea1MlAzjWaiCLZcRDt4/XmiWPo1j9pBgWFsT
         yPPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbrNgAeD9jf2Am6ujL0r+/THebP85LnmCoYP9RpraCl8Wk79Nrt2EoSdQiiZLTrj8XVf7wnQ43+VcWbcFLNPsJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyEbYxo7cQn+VaNf/Wizcy/0ym8MFVnreylL1VMQOGIl+1TWG9H
	Rt8ilqRJ3mbNazunyEXafp7m5IoZtT79mMLfbx5PfWLb19UbLneBGTAuFK72Xis6egM6HJybu/8
	U3CkxNZfwkFNquMJc8W3kwQbAo2NlpNpPL9d2
X-Gm-Gg: ASbGnctvPs1IPDnsmbn2Vw4gkjYfPspc26/jmlHpvPPd1usyQgAInPxMZw1QF8SNt/q
	/JAHXSBgC4SJC0SlsNA3hs8w4hZRjph8SRTAombk=
X-Google-Smtp-Source: AGHT+IFSYEl59MfLtXFXH4y2N6tuuaJ6F99N8iq1eoc67wUQ5QCGC8GRoRh8B300l5jEa9E2FeJkBl8QXCNaiL7MWL8=
X-Received: by 2002:a92:606:0:b0:3a7:aa54:ce07 with SMTP id
 e9e14a558f8ab-3b273372381mr518825ab.22.1734123487953; Fri, 13 Dec 2024
 12:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241128010325.946897-1-namhyung@kernel.org> <d40c6d0e-3755-4cfa-bb9e-e2aa520edb0f@linux.intel.com>
In-Reply-To: <d40c6d0e-3755-4cfa-bb9e-e2aa520edb0f@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 13 Dec 2024 12:57:56 -0800
Message-ID: <CAP-5=fXAhYGmBpnCZ_YkePAD5hOpiKoXZ8agHWPi_wHyzjWyTg@mail.gmail.com>
Subject: Re: [PATCH v2] perf tools: Avoid unaligned pointer operations
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 28, 2024 at 6:59=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
> On 2024-11-27 8:03 p.m., Namhyung Kim wrote:
> > The sample data is 64-bit aligned basically but raw data starts with
> > 32-bit length field and data follows.  In perf_event__synthesize_sample
> > it treats the sample data as a 64-bit array.  And it needs some trick
> > to update the raw data properly.
> >
> > But it seems some compilers are not happy with this and the program die=
s
> > siliently.  I found the sample parsing test failed without any messages
> > on affected systems.
> >
> > Let's update the code to use a 32-bit pointer directly and make sure th=
e
> > result is 64-bit aligned again.  No functional changes intended.
> >
> > Reviewed-by: Ian Rogers <irogers@google.com>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

nit: The commit message subject is somewhat generic. Perhaps "perf
synthetic-events: Avoid unaligned accesses for raw samples".

Thanks,
Ian
