Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83900207643
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Mar 2025 22:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741215318; cv=none; b=qlDisOCzI1U0InTXfj/koWOCLvsBqB36FrivG20HrPywWu4AxAjm2AWXjT9jXPq55+RvFpOu4gswxFf+TnXOK/JwFGBu+J2Kq2xo3kiouE2K/UEmPxcUJTiLEyWM79GetDt30dduSZFOD2YkWhp846c8W6SSzqvwLv2lyPK4cb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741215318; c=relaxed/simple;
	bh=kWrvDL4aRWGD23hUjwJg1LKH+qid0nn+ZvcDoygedpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRDqNIQjytF/89UusTAW36SPQkYfSkqFh7nwRqKDdcuZyqJlE2HfGpvU7r9K1sht7q6Gx8V53d1mzQjHab4lcRtXkdK17PbjKNqgqVNxCF6wapahPrXO8gelp0te5D1mh5weUaBn0knQnuNf9MxVFB0xzX2EtcWTLdS1VMV94P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mwn9avAp; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mwn9avAp"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2240aad70f2so52755ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Mar 2025 14:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741215317; x=1741820117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PnH7dvyAx93zYKkVwx3xrUcTVEYaETXbwPAjKVXumlE=;
        b=Mwn9avApUgilzIIj8fw10IKw32uJrYNE5nBtJAksJ5V1vDwbBGLfry7noZqgGZgNny
         ZK8Ar0yFkEMHcipS8daD81Z+uKQ5nxXrthQUeZNwXFrNVHsWy983W5L5tbZP9Vz8e7/z
         FxfAqi4ALS4LuQhXpswt9XB2zRwwox03u6WzNwBa9q5koiYzU8zEgX+bzIci+83/n66W
         SnR95DNe3782MPbwb8juBvgz7KZ11IFBbR08CK77PIxvn8tarssATSKWFv+4Hv6pBQxg
         eCXZn1laTclwd3kjfNK65ve+0+eKlekoXpd977mYGZFHybA/VZ9CRd31Xrn5hHNnPZE1
         6slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741215317; x=1741820117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PnH7dvyAx93zYKkVwx3xrUcTVEYaETXbwPAjKVXumlE=;
        b=Fi2PVylHx6IKhBkpif/3MpD9xAYpvvhmXCp8Rh9LGJLOzD+3EUnjUcLd74q9m9mFHf
         FxGH5RBFSOkE4txIieiJo9XiQ7NxcOeNn/cJJaFNIfQmukTyKDQOAq9OtudN4IDHg3D7
         /iWPtUJote8AfYWklb0u/JBq6IdkZjt16RAanhsIsgH3lYKxiOHnJyHcnuhipNFhaiZD
         lEcV1FqlrLi7Cdy/jNo5vCgVmADqSaDYU5swlXsqMqz5jJ675MOwyYe1qn5vDokx2WT6
         Xg5OsnHmIlSIUbwxssuUnaLa3ypsCphiKr/wDId4cRbEBrS8CF7KTjYzJYSucR/3aYua
         yNjA==
X-Forwarded-Encrypted: i=1; AJvYcCVjkd6d4ryHYlEIZiNObSlLuspNMRqWVA+8y+m7l7oHKq9Lfi9Tedj0ByK1GhHSj6KII/R/V/7ZP2VJMXdCFY/G@vger.kernel.org
X-Gm-Message-State: AOJu0YxRiwI1AN3WfTf9Ji5xf/CkeTct2Jm7CVWCR65j8s0UOvAb6nMx
	lWM2N/C2SFuHClLEqwc+NegqpOqoIaU2y1MVOY0Ay7vfTCwBA/z4JFXt+FZn5XlH2Yb3OyZrUeY
	I8G9sM5/oyxoJCaV9TV2EAHRE0dVSm2YTF+Ns
X-Gm-Gg: ASbGncsfIv8agiFnGByi6NaN+QC+o3gUh1nCgG7vlGJ0YqGvTUfutkfNbi2SvgPuneA
	pwdLXmquJif7hcmEp/umoMBGoLrankxpvbSL5yNak31MEZpVCWjmWm3vjb1tiZ+kp6lhnjQ8bpu
	sqlxAweq1sOIia4M+1Z67owNnYg6hf/GsJXC68hV2uOvP5eogtgYAZSCk=
X-Google-Smtp-Source: AGHT+IGhaXT718jzwjgBMJBkpqzrjXOd1Onruh+ugtQ6WiJEOFXIWmfCHdpuUXmTRtaTl8lVCaZ4y6WEQKkVv0wP4Go=
X-Received: by 2002:a17:902:f642:b0:21f:2ded:bfa0 with SMTP id
 d9443c01a7336-2240e4be146mr303445ad.25.1741215316478; Wed, 05 Mar 2025
 14:55:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228211734.33781-1-acme@kernel.org> <Z8JO5Jp2b4OyHImx@google.com>
 <Z8YU4egMWtSi_lPQ@google.com>
In-Reply-To: <Z8YU4egMWtSi_lPQ@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Mar 2025 14:55:05 -0800
X-Gm-Features: AQ5f1JqoYQIspeBgv6WEy_FqCOhkCYtiMlQ_kA8gYnT_CioYWqSJ7ZkMpD9erh8
Message-ID: <CAP-5=fURKnnZG6TUgBbE3uHFhsaLapj20dvf5OoBfzoL8ufcgQ@mail.gmail.com>
Subject: Re: [PATCH 0/6 v2] Fixups for kernel maps insertion
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 12:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, Feb 28, 2025 at 04:03:48PM -0800, Namhyung Kim wrote:
> > On Fri, Feb 28, 2025 at 06:17:28PM -0300, Arnaldo Carvalho de Melo wrot=
e:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > >
> > > Hi Namhyung,
> > >
> > >         Here are the patches from the recent session on fixing the bu=
ild
> > > when DEBUG=3D1 is used, please take a look.
> >
> > Looks good.  It's more fine-grained than I expected. :)
> >
> > >
> > >         I think that since there are no reported problems and ended u=
p
> > > being a sizeable series, we better apply it to perf-tools-next,
> >
> > Sure, will add there.
>
> Ian, are you ok with this now?

Yep, sorry for the delay.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> Thanks,
> Namhyung
>
