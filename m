Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PzoAeIsA"
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B75A41AD
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Dec 2023 10:45:15 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c77d011acso887a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Dec 2023 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701974714; x=1702579514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iWB0WIEEa4Z0tavesIqmf2tsr9YlN6E60VVd41alXDc=;
        b=PzoAeIsAmdfghISxokqvgE86RpRMa6du4ujFdlJyC//7Avkyi0Bb4Femxyd5BOK/Go
         oXmRr7wK/QUnefkwd6JCSO1BVf1rUA175yqNq8oM9sG2Qupi7lsF2iOpyMzqzTk0fxGe
         ojlA9CSWucCACFjy3t+E5tmvKqdYWEykg2402p2xUqd5mSF2UsbYMb42YrmCCKU6TgFI
         MX8TfwZmcQdZ7imlVUW/LjozxeQq8H9dTQSsEC8pfwQmbrLJ7lKGMArYycmJWy8/DF8z
         /Q8oZL7SzyqGiGSYEtAfhmes/EPc8JMZ1fzme1CF7zY7m5rezMv87W7Yl52DlDAuabXF
         +XTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701974714; x=1702579514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iWB0WIEEa4Z0tavesIqmf2tsr9YlN6E60VVd41alXDc=;
        b=v8vDaCgiRkuG9KPJteAT0ATH5QFVgHq9MnT1OG1+4/yxDNDG/u/EKlpMiJn+e/co/p
         EydajpLcWqWmf7whKV/jTBOcIhSgAQoN8LrQOzT+SROFu25ILkQPqL1KWWvrfD+fuKMa
         taQzyulvoeSOrLVLurc/enzq3Q4uSM0vK5fnC6MaAGAp+ZBP1yet+dVp8EDXHlMsUeee
         Wmc15wJU2ljW4SfX0urITS6ZPPLWiUhXMpOA9yBeDCYhgUG3qlBnO6xbmJ3Sf8GVqsg2
         ZaAmvEiMP9xfJpQZdpRDHjetAfwuyToOUqaHnQWEu9csWgvlORRqHPJmWv0eLvhAj/eE
         XUaQ==
X-Gm-Message-State: AOJu0Yz/7VFvALuVX677AAPh+S+59MEPmxOaLoOaGwXlKgkIgcY02fte
	+dz8VoN1Hh3SpUt8JWobkRXB+XTAg7MSc92/DNeW3Q==
X-Google-Smtp-Source: AGHT+IG3/oZML+t344yFzXZSbvBlxE3dHgyatuvIICstKemubny461JiiJqEooPSGNchRix6/Ykk12QMyc2QOc11Vrs=
X-Received: by 2002:a50:ccc6:0:b0:54a:ee8b:7a99 with SMTP id
 b6-20020a50ccc6000000b0054aee8b7a99mr2339edj.0.1701974713962; Thu, 07 Dec
 2023 10:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231207081635.8427-1-yangyicong@huawei.com>
In-Reply-To: <20231207081635.8427-1-yangyicong@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 7 Dec 2023 10:45:02 -0800
Message-ID: <CAP-5=fXRsxVUvOFp=9+nHZzsVbm0KxhSTL71=kvRpPZ14zTbQg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Perf fix two memory leakage
To: Yicong Yang <yangyicong@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	namhyung@kernel.org, adrian.hunter@intel.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jonathan.cameron@huawei.com, hejunhao3@huawei.com, yangyicong@hisilicon.com, 
	linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 7, 2023 at 12:20=E2=80=AFAM Yicong Yang <yangyicong@huawei.com>=
 wrote:
>
> From: Yicong Yang <yangyicong@hisilicon.com>
>
> ASan reports two memory leakage in the raw trace dump mode `perf report -=
D`.
> One is in the framework and can be reproduced when using hisi_ptt and
> arm_spe, which is fixed in Patch 1/2. Another is in the hisi_ptt parser
> and fixed in Patch 2/2.
>
> Yicong Yang (2):
>   perf header: Fix one memory leakage in
>     perf_event__fprintf_event_update()
>   perf hisi-ptt: Fix one memory leakage in
>     hisi_ptt_process_auxtrace_event()
>
>  tools/perf/util/header.c   | 5 +++--
>  tools/perf/util/hisi-ptt.c | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)

The series:

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> --
> 2.24.0
>
