Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFD81547E2;
	Thu, 16 Jan 2025 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737054516; cv=none; b=OnXhq/BjYMucYjvhOd+XDwFyBrUf5kzsV7PlWnxYaPl8gqnHJA+HRYnXouxCj1h7diyIf+H1a5Sw3pLASw4Q3ZrgPTHMtT6R5vmC+yfv1kFqBb7keV+hAHndq0jxV7HBFKHMojAkJEKuSWwblnZVO2HoPFWG3dkv9A+fMPKVbfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737054516; c=relaxed/simple;
	bh=yxNfZW+QAXZ/RGkTQd6Y3aHYqYsdXQxpiAS65GtQ/QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q8+QU3Oh+BBvhRgoG1tQUO+q5N02zIaCuf4X2A3Hzf6BOqr1wB/5GLdK659doR2AEgdiAuTGPBZu7l2rwdmbUxhBs2gVP5buid15N7BvuWh9CEKRcO0wLQUcWBlieItAzRfTrlsMpYlbqaSTQQr1TfXHkmCfH5EZcH/skXTqSOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f44353649aso1900570a91.0;
        Thu, 16 Jan 2025 11:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737054514; x=1737659314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9woIcLoaAyHZhNforMi4bYkNy4vsMV19L2RMrtgrBYw=;
        b=nznm6wKLejZw9bfH/q0BlzsoZkajiPtzsY/XDnrdMNhWbnnt3u66P6gZ9UAR+UqvXD
         ciNPcr+3A/cklAbLoEs3wYh4gPro4LcKm1PUk8p7Oxwy5BXL8NDBL2g569tbIjE4t2cl
         kQBRzXxfoKdsY47kdfInPHQNEPyV9QX5il1cGWMZqwXRbiEBMYHZfs5CUy0slRCjIRdh
         hx9dXQKye5zS3Oq2glSTLu6RpTKyse/Xnl2GRT0ejU2IuxO4pxncdUIqKJHZpDu5Qim3
         KVUTElC8xt4mqGyEkEyycieMFgVHwSV4B31uF3Ukyd9GX81NJnhDgjmAnP5F5zjl2uDi
         OKJg==
X-Forwarded-Encrypted: i=1; AJvYcCVCByRgvlk5FavTn8MI7Dlf4ZrtlKTcWaF+P+fRpLvgNP12jQ503zTJT2xAoJixHAAfRCLufYB8Z8F/vI5Nt3AS@vger.kernel.org
X-Gm-Message-State: AOJu0YwEmrI/nSKVzereCoA2CpACb32CttSLP5l65cQWwOo3IfGeChEH
	s1lXhBvrp8lQ47JlKStLlUSF8/2k98L92x1JJTA5ryXTr/1YADNcGS/xBSfDhJYqSVYLNYGH3K2
	3Ue0vtwgym2mPUE3+Pq7VLb63hmE=
X-Gm-Gg: ASbGncvzwTdnJfojjtke8HSIO9qMvdy7GTY+OTCBmy9mPh8rYmFLB2yzmkufsYmCn8C
	71l9ZoGPt8mXTZ/3VQPus8gPkn70FTiub9vBT
X-Google-Smtp-Source: AGHT+IFKvpTmzA9k8DNNvuwI0izIJrCrJXTSmbKSYcntOAlfG80qO3OCLrn7LxwegWue0Z/QVtDoGwHyOTOe77b1QOc=
X-Received: by 2002:a17:90a:c2c7:b0:2ee:ba84:5cac with SMTP id
 98e67ed59e1d1-2f548ea5a01mr50926421a91.7.1737054514288; Thu, 16 Jan 2025
 11:08:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210200847.1023139-1-ctshao@google.com> <20241210200847.1023139-3-ctshao@google.com>
 <Z1nk9owKE_xHVh1i@google.com>
In-Reply-To: <Z1nk9owKE_xHVh1i@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 16 Jan 2025 11:08:23 -0800
X-Gm-Features: AbW1kvaWhMtt64iP1abE7wBHHvVefrxI4Bq_UEem5qo2qPOM0DlYpngavjSDHug
Message-ID: <CAM9d7cgXuSMbV2hMKZqUQOHU=c7Gix2sxh4C=BbLNSJEaZX6Yg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] perf lock: Rename fields in lock_type_table
To: Chun-Tse Shao <ctshao@google.com>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, nick.forrington@arm.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Dec 11, 2024 at 11:20=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> On Tue, Dec 10, 2024 at 12:08:22PM -0800, Chun-Tse Shao wrote:
> > `lock_type_table` contains `name` and `str` which can be confusing.
> > Rename them to `flags_name` and `lock_name` and add descriptions to
> > enhance understanding.
> > Tested by building perf for x86.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>

I'm trying to process this patchset but it doesn't apply to perf-tools-next
anymore.  Can you please rebase?

Thanks,
Namhyung
