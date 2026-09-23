Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3696555293F
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790181998; cv=pass; b=HKqYm1Ytjpqedeq9WM7dciVOd14HJfN0iOMSETVxe8u6o29mMTt87g14qYTs6aoVdzugbd3cImyKyC5PaCsG4fd3nPweQ+tRKQ8/UFLFOXDT80QsPsC9PrC/p7H3Bl5YVgcaIOmUovSBOT8kJH3Qn8eyynS07prrRjX7b48iNDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790181998; c=relaxed/simple;
	bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egp9DcJYBGEdkYHNai0Nmy2mdk4lTihB99Bg9J/HXRNfEXHiKcig85zCUDlNajQetuUM4zSTupB87B4AZ+VpQ0RFgumSi1RR/SRSCfLKsBAvtjv1rIhqEqUSQbC4Z4AmfU/AiWvoEkUiiF010SGb4N6xcaTD4dRwGn5xpvhwSzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jG1Oxmrg; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jG1Oxmrg"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so854059a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 09:46:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790181992; cv=none;
        d=google.com; s=arc-20260327;
        b=ZRfsUJ6unNb6zwcjVun2qx5K8i4r6H2KmvUxR+Wgc3lvJBDIW+yJX/yqeEeCZrG3G/
         2gjPWLpy0U8XVCAI3F6nwOzDWvUhutIdZNLYZ9BYnNiYyXk9eFldO6kIoh730XFg5i1e
         NbD/7gO+/BG/QKBPVUI3r7BnNY1v0EZgw6NjU9cx6RgzQlJxos/SDBG8fMcpksfzK2Gb
         InZUddDPlF8TAgX/lbiNW/d+hIQaaWT71fk9U+NELCXKuUT0w9dB4ThWXZRMl6vj4zw3
         xOg+YH3WpzhGpdkQHxQsCqT/tBh7l+pRDN6sXQsDTYTrEM4osqe2FbNvQg7D0J34XHBY
         43ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
        fh=SOh3LeESQpka8RePpg7qtpAO5ZMBd7ddRKnudksL9/o=;
        b=aU+7eEhdT6yP4pKrqEaN0Hh13Mt4lQZAOtM8QvW8Mf+uh9VynXAdhRvA3uDyB+L+sP
         MFTGQZbn74XWgONkxIbscq6XkdlE9XIlpVNGxUUPXIoX5B54zGofLgls31bH8rlLMOZ1
         NzFj5VAaW7QbdJiWj8aBFJ3amkKdLuzhVlnohgFmgVXGUIgTyX+nznDN3CFVnxFz+o53
         y4CaoxNvZm8FnTrhv5OGwB82eCjU9vHAwD3MlIW1CQID45QSx+TL2LDU6apqqetSLiVJ
         PvwMcfuUmJJxZh4dyP9mGUolPw1l8+QCenyZ0dNUpa5kFqGo9DgsbaooPggTvGBFo5QH
         l7iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790181992; x=1790786792; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
        b=jG1Oxmrg8SoCun82jI7IJOzdWpUCh8nsLGresy3WjZzOmnNw9TFzaYm2lScTqqhEfi
         ycyDlLE1qFfJScNNEZWysX0vuY0XS4VU9d0ikXOM3OvzHA8NAmXz2E8oANLSsXgceiWP
         z6aO4M0J/Bo1wjrE7va8Z5/TnpRv5OH06LVMym6bbXtsIzuHV/+ywjENODEIrl80YUAE
         riOe4Y9fL2jUwC3bXBcyzzYl3Id+nWIW/zW5FoQk5mrhc6CrtVYVBV3p8/bBvj5NeiLO
         /H8krlh/Bfr+wVNeSf/mC16FraPg0fR+0EjbjZ7idzZPu3Iet3WnajfkCxYVDf1ZA2aB
         Ch3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790181992; x=1790786792;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5ttgwH8UHuDsbpe+g+LIC07zUw8mgYUjByGb6XeD0sc=;
        b=QO/MOJyeakVzrrMWAF1fKi4o9Fcsv+9IeWWPJYmoOA61u0odMjeRO25tW4Z2HIHyb/
         FfuFY4jbP4oThBZdQExhLesG13lg0AoYUydMNBYsUhUR/aLn1fudnxAzmQlSXy/0zZJV
         kKcYJb/pXCjOETiutE5jEE8FboZAAtfQbRM5OMNeLro1jZTBTHsHHnTpBB8sOHP7tP4v
         QxrkpNFTVVjRjA4LOFl3/uQckkc0ymE5dE3kFEYyOpwPkyT/VXQu/mfgZdAGPdxL7BSe
         k9VxKX/NCmTSd353q/140twOxC8pfkgipfokcSTpKRZ6JvRIWGfLtOTKEZyBrP4BKdj9
         BoTw==
X-Forwarded-Encrypted: i=1; AKwUvBy3xSExI2FFtPp3vwNm03KoD+Un19MOffJj3sE5BFD1JbfK/8ZprVFXqcVVeDf6BVHN0SckWAS6IeIMHK5DqyQG@vger.kernel.org
X-Gm-Message-State: AFuF++nN+kdl14HyhC5JJsoZdP5nMz7qI/Bsh4y1DUUV50u3YVI8rBVp
	EevxgQarra5ifOjr0YdsTtPDZrHlOjQ6Y1oxqzcuzb/0eXvu3GqEovgYuu5HXeypT14f3zRWaVt
	lvWsZdV1dvSYCN6zIR2KS3iSTcwrr0wk=
X-Gm-Gg: AYBFou1Uo3Ffmr3QvD6Eie8dgtK2q2Eb59QohD6zcWEExtz+HoC5KxiJss1eshRxotx
	WvP2mwdvddYlwhfJRb/LR0tY4qaVe/X4fisRh0sdoNTOBXIDSIiJGXX74GTunTmx51tFEvAfeHV
	6Ijubtt+QnYwz9IbD637XWNxdyli2rVeZ2iTBQnA9D7TkoFp048cNqY/tSdBI9cxj7rQCNxKQpi
	E4ECbDMcJtCngONitHWT0mYkA6QbXKU5lzgCzJ8yAJIMl4BdVYwW6XuPScwUV03spJ8qkku7OEZ
	vEQ3JHEdlWYTDYuXWexos75Qguu7WY9zbzq1rvvO56sXCM68WhZL4n+FQiWxxQ4McAplsdPR7AE
	U7y0IC+DbREzzAzK8HEhd8gd7NuzBGLMgXm85
X-Received: by 2002:a17:90b:2742:b0:39e:4c7e:f03f with SMTP id
 98e67ed59e1d1-3a07e5808demr2908153a91.28.1790181992225; Wed, 23 Sep 2026
 09:46:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260810164622.1829843-1-puranjay@kernel.org> <CANk7y0ixo5a3Vfzj_HVhVHRNce2Rsit4pP27GCtXd4jHHzmiKg@mail.gmail.com>
 <CAEf4BzapC=7YM2QLMyKKfyOWGgBTfEJmPPN8e9Jf5xT9SutBTQ@mail.gmail.com> <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
In-Reply-To: <dfa8362e-0dad-4f23-9d2e-dde03cb5facc@linaro.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 23 Sep 2026 09:46:20 -0700
X-Gm-Features: AcwNN1UoxvmW1a-b3T0PDtkRMDhPQq20k4NzNgV-SyDiYVuDhWZJEV9Emssz7sE
Message-ID: <CAEf4BzZ=ahQNtA-1KdZFRONXMOEkV9Nb1OUY==JRQCarkbMM0Q@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] arm64: Add BRBE support for bpf_get_branch_snapshot()
To: James Clark <james.clark@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay12@gmail.com>, bpf@vger.kernel.org, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:15=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
>
>
> On 22/09/2026 21:40, Andrii Nakryiko wrote:
> > On Tue, Sep 1, 2026 at 6:45=E2=80=AFAM Puranjay Mohan <puranjay12@gmail=
.com> wrote:
> >>
> >> Hi James,
> >>
> >> Can you review this version of the patchset? It is implementing what
> >> we discussed in the thread on the last version.
> >>
> >
> > James, do you mind reviewing the patches again, seems like Puranjay
> > went with the implementation you suggested, would be nice to review
> > and ack, if it looks good to you.
> >
> > Mark, Will, you guys seems to be designated as maintainers for
> > drivers/perf/arm_brbe.c, can you please take a look and give your
> > feedback as well? This is important and useful feature for newer arm64
> > CPUs, it would be great to get access to this functionality that we
> > had on x86-64 side for a long while now. Please help get this upstream
> > or, if it's not in the right shape, guide Puranjay towards a better
> > implementation. Thank you!
> >
>
> LGTM, and the Sashiko review is good too. It does conflict with the
> FEAT_NMI patches on the list, and you'd have to disable NMIs but as it
> stands right now it's ok.
>
> Reviewed-by: James Clark <james.clark@linaro.org>
>

Thank you, James! Mark, Will, do you have any suggestions on correct
sequencing of things and how we should proceed? Thanks!
>
>
