Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BE61DE3CA
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jan 2025 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736183830; cv=none; b=hSZrAbwAbMK2P0oz9AB+vl8q5iDZPceXUshSqLNDXyBS6x18JyPBnNJqK5gMtMwT4UZb1IMd2XRKveF5XALptek3O5fMnsRpA5o+GLyjHf4Fsk7/RRL17TRIikyLalPjU6Ph4v+t7MfJ36bBusqxo5qxtB+TlxTKJnwtsKeThzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736183830; c=relaxed/simple;
	bh=xhn3nqer+Yv1wd1X4//8Y3M3zQrwl6kxv7xqijPdrgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M32QKE1NAaK8a/O33UaulUH3tm1oZC+QEeIX7ONXk88Jzf2wqOAj2xV81iOKb5EqOkeNgH5HFWBQOA8vn8U2thUPljtVGP+NRzx0kFVmEfG/8Eahj8s+/9wxCudq70lFNTrBM04CX+XEFgVqrXr/vEfWxBu4DVyVUqFSgX3Go+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Du1Soh9N; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Du1Soh9N"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so287375ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jan 2025 09:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736183828; x=1736788628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xhn3nqer+Yv1wd1X4//8Y3M3zQrwl6kxv7xqijPdrgk=;
        b=Du1Soh9NJZAZWBgyywgAKvd0oryInDeeI3BtklgZJLpKGKaMESSEiWTos/PzxH/dKP
         hQa4edDYdo23V6gAgTnKXCeDrNUctYmfgGg12rJ2nLPFa+WhES7Fh5ovPhY6yswLm5pt
         +VzlcbyUx1y/MeLh5rvpGNw4t9tJZysZsa3eOcOjUv93hcsYTVs7TCvALn/nkbASzag+
         v7HlUajPUWN3eWIFQGxzSIfXNTh9uQ7n59s8xN9DFe8pIgDwuIBb/bDnu+XEsv2LzKMB
         l0IV0glQJ7zUaiRcRXuMDHT+XXDnrT/mYBUo+mCRe2LzEE3B6tRQSp4JRRrUvInW+G9+
         avzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736183828; x=1736788628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhn3nqer+Yv1wd1X4//8Y3M3zQrwl6kxv7xqijPdrgk=;
        b=exP7fUPAOIjV69k0aDN/dAI/S7P4S7sev7Lv6kSAcknlfXa6pYvRqUOB7gj6Z/oIcK
         kimabWFxaPklmc2g1HuXeZgnMAJkgXGMOa3qg5b9hVrt7uS9LGSzjYAqsLcQjn1qh+xn
         fk/lqHyYmHTWfJnHtrhWCvZhLTKhKInbYX3iblJIC2a69RAYrwM+Ja931ODBvDzllcnr
         qa7Q5GwSPbx0Ja01RC2blWGGKOf4Ia1Pdc6wB5rDfQ53AGc8/HYSC6p+6D/IPHOzKunC
         Y9gvF+6R5I13vPrb36GUwrHlC380Pq3Gbuj8tBrcVsE7Ov699ZY1sz+ksqrLSZKOZfuG
         JXbw==
X-Forwarded-Encrypted: i=1; AJvYcCXe7c8+KKNlbegCreHOKlSF/sVT/ZXD+CyzhGCzAtdDYonOK1niNkMy4O4nurb5rwITJua43EQZUnS8IGhsXm8t@vger.kernel.org
X-Gm-Message-State: AOJu0YxOZZVe9wXrhnj/6tjICJDnHPc0SuKLFX5nUkJciY0lcJsI8aA1
	O0Jh6LnODfZxmRe7tkOTto1XNrHJbo1bGiiqu5sXHu6kDkdHP/n5cXrLm7a6quW3v78W6MPV//B
	eG0XvimjOcZ6gFFvenNvTCmA5ktapZYVFaBd+
X-Gm-Gg: ASbGncv3d1BIX6ZAFvplCSTr9kLnrEsxxGjLGkQZ0pA6QNENro8oX1uS7CghG3oiOKw
	WJGESdmqCdSvt9ckc2ukfW56jgFImvYhlRdwOdTKBZtLyR4D5mHHRT3XThcBwnDcq51yg
X-Google-Smtp-Source: AGHT+IHXjvHAqCctEeQaoW76FWJw4OftTUEn7E/9S8G3CETYtw+ZenqNrzEnUTiAfQPVvyuVGbddSh4V8qMvqfGNOkw=
X-Received: by 2002:a05:6e02:1b06:b0:3a7:c721:57e2 with SMTP id
 e9e14a558f8ab-3cde2c2154dmr4802935ab.21.1736183827684; Mon, 06 Jan 2025
 09:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209222800.296000-1-irogers@google.com> <CAP-5=fWr9R74-NbKbW96otG6KitQYaQng4D40Bv4z9ov9yvNJA@mail.gmail.com>
 <Z1iQhL4WXFL4Wf27@x1> <2ae362c8-b8f4-453e-9c92-a25ad989ffe4@linux.intel.com>
In-Reply-To: <2ae362c8-b8f4-453e-9c92-a25ad989ffe4@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jan 2025 09:16:56 -0800
Message-ID: <CAP-5=fUTXzZfRqre0Vai_5pxue_mAvb9oh-Ea9Sgr7U=Lrm_Nw@mail.gmail.com>
Subject: Re: [PATCH v1 00/22] Intel vendor events and TMA 5.01 metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:24=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2024-12-10 2:03 p.m., Arnaldo Carvalho de Melo wrote:
> > On Mon, Dec 09, 2024 at 04:44:27PM -0800, Ian Rogers wrote:
> >> On Mon, Dec 9, 2024 at 2:28=E2=80=AFPM Ian Rogers <irogers@google.com>=
 wrote:
> >>>
> >>> Update the Intel vendor events to the latest.
> >>> Update the metrics to TMA 5.01.
> >>> Add Arrowlake support.
> >>> Add metrics for LNL and GNR.
> >>> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> >>>
> >>> The perf json was generated using the script:
> >>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.p=
y
> >>> with the generated json being in:
> >>> https://github.com/intel/perfmon/tree/main/scripts/perf
> >>>
> >>> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> >>> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com> and
> >>> Weilin Wang <weilin.wang@intel.com> for helping get this patch series
> >>> together.
> >>
> >> I should have also said, this series requires:
> >> https://lore.kernel.org/all/20241113165558.628856-1-irogers@google.com=
/
> >
> > Applying that one now to perf-tools-next,
> >
> > Kan, can I have your Acked-by or Reviewed-by?
> >
>
> Thanks Ian for the series!
>
> Sure.
>
> Acked-by: Kan Liang <kan.liang@linux.intel.com>

Happy new year and thanks Kan! Arnaldo, Namhyung please let me know if
there is anything more necessary for this series. I don't believe it
needs a rebase.

Thanks,
Ian
