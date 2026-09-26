Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F527254B03
	for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790409095; cv=none; b=T2pbGm3vWgqAHyRL8CCy5Tyx+NwX4t9Ps3HH6GeSDL8rJA0yOXposiQQdsWHKzXrHX/0MK51WApJqK3p5K5aeLwZhMols0SjILtTDLwaghFYXsryJNxnagIidrm5N83z4XJDqCpjqZTzmVd7o6bI4jsU0IMzXtkDeW5DJUs2Jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790409095; c=relaxed/simple;
	bh=IL//iGJMhExxFm2mZIN8VFOrUAaJYRKyqi8Ao7gV3do=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1C4upfLFT4dar/okPkK9cveoTfFstuY+2ilpvSNiRPV+r4gvKTiycsgBREFVT6umEajpiKJ+O/8yWjWVPoDpB2jwNaQg2TsyaYzI3QKYkywx7Kcju2tB5mSnCsM30BOd6eBcL+uAI7jS6Gy7DmW/aBKZ58LiQyCn+q2waMw60o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bhype7qO; arc=none smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bhype7qO"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c8319dd4a5so599286e0c.1
        for <linux-perf-users@vger.kernel.org>; Sat, 26 Sep 2026 00:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790409093; x=1791013893; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RZJAphD42mAguDcm9XWeyJ8mrkVHXyKCrmnd7YhuSH4=;
        b=bhype7qOIgCHL4VxAoe9084lnvESFIN+Y3+wI9+3sCav9K49rBdEIWBMSKsapQypTt
         tTY3ZnSA6Bq4RFU5ZGHEi242Dk1IYLaeaLaHUksr57pujczJInW6e1PBYcBb4NqdGr8e
         sjs2JVdB1UD157O/aLqvUp33MRQSqfig2kEzHy2ir+Bjf9bbcWH+OlWYjZUTTDJ2edRA
         XyxYzHwvhcuRJ/VZ3OSWz10mRdwN4OMegTIgG0D/kKhLwokZrwh3UAlLcx9PZJYo2Zlw
         uhNcosadUtoygO/36JJ4dCekML9BkiPwIeLRsd4bImGFtyOjDJ6MD1JlOQjaUU4u1oWV
         rMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790409093; x=1791013893;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=RZJAphD42mAguDcm9XWeyJ8mrkVHXyKCrmnd7YhuSH4=;
        b=yO/2Ha9/FdryKRaek8Hq7imoCroKwFZosz2NFp6M5X+TO5NjvpkFuku8BY+4gFBMX4
         qdrUwNN4/OQR5NI0Pl6ziTF+iFXaa2VkLPTCuhS9NnArF9Y58lALBoY/3vGVDrAfZSFT
         WPxBQa0Uy0o4q10tytHOFwJ0Eyte0OGlKTStsTy7JUyox5ENi+05/J/5jwbMhddvotx1
         Y5S0H9CPkmPKrtTmzZb8f9xJAb6Nh6MqUBXn57wur4VRy8we4iVOJyXl0TU5Yhg00bM5
         vzWwk3vhNSFFGL+qqh8ULLdbBOHobL1S/QQFqoacDmROV1hG0+2Fr34fEDN01zuXzYyb
         OtYw==
X-Forwarded-Encrypted: i=1; AKwUvByY0OUCcFM1mGy1VA+U4GxSGuHCsfdtmfrzTHkQXHtjQSZkYiax/kUN0IXS8vCtEIlAqKTfBePaEiOGuvWXJ5Ij@vger.kernel.org
X-Gm-Message-State: AFuF++lRUgMqX3K0Liv9egcN9PIt1buLGAQ1N2XEQLNCXr3F2lSeEwHE
	9kqFMHuM55g+GRcUAHSqSzIFoX7NHEoNY/o9uKWmBrel6ChJ/vV9mafI
X-Gm-Gg: AYBFou0s04UG2CDagFZbZYTn2lZeaXqDFq8pNu9U7bkJU84dLA2WNvSJeIa0Y8bmxDt
	mt0/Duzc2xAavB1SgVfUEG2eLDaLBQC7Cv8AZHnSJ9SnVbLOK/2fQD/5ib9L0FJWKUTU/mL8/Xf
	n3CV4jF1fvC21We6gqd85DnobHswfNRshx/Za+/lmjwHkQ+9AyN8WX1awNEyrfHvJds/isB9bnT
	NxQ8CpM/kB4RG1RAcA1sN2LBXRKXeScA1sJDfPYWWGFv9RQXHmBWeV1ScDF+O6ytcQ5/ohSVRBJ
	rYGKfuQmIOydARCM55fP0TCXJlT+1GN310XH3DsUh60F0qVVr/m3DKVe6OtmwjXOLegmIbHVZRp
	t715c/VbQ8kNzIPpaYAEAVdBTsVSIvXUe44pZv5NSL0NNahmH2aziFx1Mm3O0pB1gaAcunRcS45
	eSw4uvVm/WQfB1RmlD5DN2oMFaia5QEHcz0qoTYwG0KKj/BpGrK9nzia4TwrzyPMCGdnFDpO20m
	SiBtXvKKtAmGROq
X-Received: by 2002:a05:6102:5707:b0:7a4:85a8:fbc5 with SMTP id ada2fe7eead31-7af1d1bb461mr3150263137.16.1790409092972;
        Sat, 26 Sep 2026 00:51:32 -0700 (PDT)
Received: from localhost (187-26-79-111.3g.claro.net.br. [187.26.79.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b257379sm1644514137.4.2026.09.26.00.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 00:51:31 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Sat, 26 Sep 2026 09:51:25 +0200
To: Ian Rogers <irogers@google.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf tools: Bump the minimum Python version to 3.9
Message-ID: <ard5fVHYXTckW18b@localhost>
References: <arb9OMEQ8HCcw-9O@x2>
 <CAP-5=fX6+M8fKmSTzCy5HufEQf422h0vavTTb_RX3HYRYo8nfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX6+M8fKmSTzCy5HufEQf422h0vavTTb_RX3HYRYo8nfw@mail.gmail.com>

On Fri, Sep 25, 2026 at 05:22:58PM -0700, Ian Rogers wrote:
> On Fri, Sep 25, 2026 at 4:01 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> > perf's build only refused interpreters older than 3.6, the check added
> > when jevents.py started using f-strings, and jevents.py carried a
> > removesuffix() shim to stay usable on them.

> > Suggested-by: Ian Rogers <irogers@google.com>
> > Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > Assisted-by: LLM
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

   I addressed a sashiko comment avoir the python binding in v2, does
your reviewed-by stands for v2 as well? Mauro?

Cheers,

- Arnaldo
