Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8B16FC3
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Sep 2025 12:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758372877; cv=none; b=jKFeT7JJxE/jBQ1nJvZ0s48Fl0ZyIecLuJ0rv14ObYtVxdRDb4Fbu5Hn17V+X1Po+yEEJmOyUbAq2PX2vJMC2AfYq6rrBKs/0IbKDI6Nqg5E7kSldZa9xOekpZ3eDpDZnic4aaGIVYxZPR8Pzoad0GnMEyXs1OD8fply5pnw3nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758372877; c=relaxed/simple;
	bh=jhobhv2RLVdfHulKX9P9/3vvH/K9sWU3vNhyJeae0HY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KEEJC5N08Q2wqPq0yypV+hCQpnZFGvJoFy528Ypcga2nUaoZhoCgvth1mz+sn97JNScA2/GuutwLl3haZw0zwX8sPGE6B5ueePnFKLuo8X5Eosrx7hyB8ewMAAVuSYqU5QNV3aUwheoIWh8RNk/o4uOOw1XFFciYv0Akt+LY7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x8Xwn5J/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x8Xwn5J/"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2731ff54949so21575ad.1
        for <linux-perf-users@vger.kernel.org>; Sat, 20 Sep 2025 05:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758372875; x=1758977675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jhobhv2RLVdfHulKX9P9/3vvH/K9sWU3vNhyJeae0HY=;
        b=x8Xwn5J/qPzrOZzKs0PYHw1qe6NSnYTtrs88Nfcvl31obXSg/DP8RsjIiDLVzVKwTR
         K/ANA6jL086D/nmgXGKlV/iAC6JJ3stigkJ1a1cc0TncvltD+GkHzMSkGlBWaSiyw1Ds
         fLsLoLYBrJ0pIm0OoA95ZS2DMGdZvSv2DDFIFL7rqSJ4r6Hfz0yHzN7rExfaUtMB5i00
         iP1nf0iQXHvqZOq2XVLWrgHcy9zcCjtvHmUW/uj7ND355a+PMISxUcIQ9MQcfjueX+GO
         wLV8a4Hcxb/c020FNz5A2xA86ooiNe3dHfxhBAHR478hH0CEBLvV/Gcev3D/BV1BEpM9
         cVew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758372875; x=1758977675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhobhv2RLVdfHulKX9P9/3vvH/K9sWU3vNhyJeae0HY=;
        b=CY7zMBUWrzYv8W/NnerC8l+xchkAY/e3Q8fSkBHl9etOI7TT8mahVI1rFSA5iN4/X8
         tmRaiwruEw6FPXfkhdxUENL9k1ow9FaS9mlDnX6yi06yVRuNzEE8vx773ebtx4WASlUL
         iFN3n0DnHlA9SscRTGu722+/bT9cgGRAmO2TgHu+GqsSqLwW9zC5e9mf9FlKjDbGCwiD
         xWvnJs/lSRv39UP23PanuT23vWfFAJkeEg/GNHd5t32xQvsbwIifx9SmDfGc6BUFYHwM
         mr+LHgh3kHKyllAF+fQizgSTCq0nzwkrmqlyUTpUTASjqQTxvmVsdqvFwvuF9srCb4uV
         6fCA==
X-Forwarded-Encrypted: i=1; AJvYcCXYHNmROPP8JOIXoDaJr/+0laNqFaDflR+xrigK8QiQ15B7U71ZLdz/lJEB4IEQBiGcCcvFbDTcR0/VhSHnXh9p@vger.kernel.org
X-Gm-Message-State: AOJu0YwDDiVc6d/w2kpb/Dgn5f1vt5/HJqYAwHJc6RHw4vrXo9tha2y+
	EIgAJNyTQ3LRMT4N+FU8ilSwSBxyz3wjjAKvIiEp6rCXRMb3fVrhxTaniDDGxaqUg82QJB4zxi2
	StmZzKf4Gm/918uPh9Bh7DgtEOz/PGwhOtKQGpVOZ
X-Gm-Gg: ASbGncu20hv/I/rYwBlj52ePZPeVifK2u/Xf+nyLbnpSn62zHESdsJ/2NUbSGVDkmAZ
	mnBUJUAi5StgIfje0Iy6dPYmUzu79GyjOrsWaSgyo9Gw+OOtRcHDrPQfqYj/41wm82HxEbL4m1l
	qVLCRnCsicvLsewixx7W0jEoVdxPvWRLDS+I1PgrSeLJhVkP0ODmT7xX6MFO7F5C8/nnb0+NdaP
	mcadeAX
X-Google-Smtp-Source: AGHT+IHZBL/6elAcM8Uka2LmgkTCiy+wG9E+jbfoFwlySI1v98FIZXMU2W4efpjv7OyCWtlQfuSyoAcVTsaoRNeNa6o=
X-Received: by 2002:a17:902:d483:b0:26a:a69:1d8c with SMTP id
 d9443c01a7336-26a0a694ef0mr8410315ad.17.1758372874806; Sat, 20 Sep 2025
 05:54:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904044653.1002362-1-irogers@google.com> <8630f8dd4ff3ef050b3517b86ffa9fcae695e675.camel@intel.com>
In-Reply-To: <8630f8dd4ff3ef050b3517b86ffa9fcae695e675.camel@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 20 Sep 2025 05:54:23 -0700
X-Gm-Features: AS18NWB1yUUnv5WIBGyhk_W7AEfT-_rwDmz-mupz6_mSoe1OlqASNjoN-lBmOc8
Message-ID: <CAP-5=fXiv9DV-57=Ngc+zN6B=tP+4+zpt++1pLx_BdpJVa+VYg@mail.gmail.com>
Subject: Re: [PATCH v6 00/22] Python generated Intel metrics
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "Baker, Edward" <edward.baker@intel.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"xu.yang_2@nxp.com" <xu.yang_2@nxp.com>, "Biggers, Caleb" <caleb.biggers@intel.com>, 
	"Hunter, Adrian" <adrian.hunter@intel.com>, "Taylor, Perry" <perry.taylor@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"sandipan.das@amd.com" <sandipan.das@amd.com>, "james.clark@linaro.org" <james.clark@linaro.org>, 
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "john.g.garry@oracle.com" <john.g.garry@oracle.com>, 
	"bgray@linux.ibm.com" <bgray@linux.ibm.com>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"renyu.zj@linux.alibaba.com" <renyu.zj@linux.alibaba.com>, "acme@kernel.org" <acme@kernel.org>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 8:31=E2=80=AFAM Falcon, Thomas <thomas.falcon@intel=
.com> wrote:
>
> On Wed, 2025-09-03 at 21:46 -0700, Ian Rogers wrote:
> > Generate twenty sets of additional metrics for Intel. Rapl and Idle
> > metrics aren't specific to Intel but are placed here for ease and
> > convenience. Smi and tsx metrics are added so they can be dropped from
> > the per model json files. There are four uncore sets of metrics and
> > eleven core metrics. Add a CheckPmu function to metric to simplify
> > detecting the presence of hybrid PMUs in events. Metrics with
> > experimental events are flagged as experimental in their description.
> >
> > The patches should be applied on top of:
> > https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.co=
m/
>
> Tested on Alder Lake, Arrow Lake, and Sapphire Rapids.
>
> Tested-by: Thomas Falcon <thomas.falcon@intel.com>

Thanks Thomas! I'll repost with the missed signed-off-by tag.

This series links to the AMD series
(https://lore.kernel.org/lkml/20250829033138.4166591-1-irogers@google.com/)=
.
I'll not apply your tested-by tag to that given those models weren't
tested.
The AMD series links to the foundation patches
(https://lore.kernel.org/lkml/20250829030727.4159703-1-irogers@google.com/)
and so I'd like to add your tag there.
The foundation series links to the patches changing how legacy
hardware events are handled, moving the handling to json
(https://lore.kernel.org/lkml/20250828205930.4007284-1-irogers@google.com/)=
.
The dependency there is just because those patches also generate json
events in the Makefile using python, the main theme of the patches I
think it outside of your testing here, so I'll not apply your
tested-by tag to those patches.

Thanks again,
Ian
