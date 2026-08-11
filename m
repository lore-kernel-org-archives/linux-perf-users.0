Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376ED23A9BD
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Aug 2026 01:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786413025; cv=none; b=KA5+cSBlACdGyuSaFhSnOxVffwTQ5d3Hnn+09nu7ufvigZthO7Ybr85/bV9B2Bnokzhrdvddj1//rDMGOQ8MDliwv8j90bAJUnz6yuuMzjCXVWJ/Uzg6d3vAfdntN90Q6TYpCRW+Cg1k1sHaAs8AqDYmaNTzNkL0mXvEx5Tn5fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786413025; c=relaxed/simple;
	bh=JRYFXHFQnEQVkut46pK6KEbM+8WY2joXd4r98Hh9guc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8MNKiCeoKloiLHhvj58OqWucesRdBP/PaOx5JEPqzgYRDmHhYH+qPkdmhtKT4RLSCvHPipPhRyrXJVgbeXAzc/m+gIhqnBqxyVzV2/boxtaUufzfPYYM1+E5h0Y2/x38cR/2B29Sez78r7FsbChGv1ZRKgACIJ13j01vZ3t9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PewjN6PE; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PewjN6PE"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so36626085ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Aug 2026 18:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786413023; x=1787017823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8P9luPmYGY2IMgGbaRGWkOi9tDtMbjeSt2sylzpzEZY=;
        b=PewjN6PEVZO4jMul9UOZS07igQ+qj4inDJYglcwHgTjdCLqlca0wu5tFhL02gATxW5
         0zC+rMJdyfVVMOt3oOvR+5DeQnVyYzACHy9gMTtzG7xMpn9nhfmfIvA9cUv+eVWgsQUb
         TwwEY6qbpGaA9gAW+ta/F3EUsU7x+Lgbk9VxeR/tEj2tQ7BNYTaR76Fkx4i5+pgstJD8
         r4A2RlL8J22sPtEqdSmS53D96Kxw/+GdFvi/WM49VWISeI1F3yRh5MdcmTwZcurL91au
         8OG4bX0Y2f/fJf0FFxkkpM1BgoNdpKbZKM8I4Z4aPCWPiZjRC60r9HQ7kwJ0jzCU3ROh
         nQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786413023; x=1787017823;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8P9luPmYGY2IMgGbaRGWkOi9tDtMbjeSt2sylzpzEZY=;
        b=on1GE2AIoFFo0yYlYXdhl93ZrWb/VIa3tBmP24GRtNtoG2IJcsFZzJcMybIu3NcIIa
         yM5q9Mib0SobAFHJLJhUI7yhPUtUcLUeQm7hhaAmA7Twt8APbT3Lksxi8D2aWKo/s3I+
         uEFqvawVpHoqn23Z0EMDI1XCB4sEvsItVTOuiRFP3zJ9BUx5IhlMO4Om+ZNoYFX8i1eU
         EouN16cONMbY5zLN3FzzicLR/PvOjMMdMv2/Z+6Jesvuf8kGptqHq/nrysFyCZlYwxa+
         LZ7fmY8gDfkWCb6srn6x2dy/BvYIoywEzR5m4a32Ba+hfkk/BW5/CBJlBze81PUKGxun
         K/Tw==
X-Forwarded-Encrypted: i=1; AHgh+RovcF427MfuEebiEeBCdxZcsKxltXqKTGezKrJlGPgxlaB/VNryt+i86B4l1frZXshZXJeQ/04cXRWIouLHnJD8@vger.kernel.org
X-Gm-Message-State: AOJu0YxAeOjvyyh9u02XPA+vdOxtfgJOjyRqp5sJAUwISrY/xzfluVI/
	XQRuhGJguvKOY5HXOUf/EMrb7QpuVlQUSJEo7hPl/WBGEIeUUEeU9TdV
X-Gm-Gg: AR+sD132LassMUXsX2XpQUzUpqiNHcteLGZnblsKSkpiE5qMJXUJEq8orYYp1ilgYPK
	H6aJXdbLP7v1BqKlQ+c4qSYncYc+D0B2MoB4ikXWc8THc24SAmzKUUHH//P+y26zEoI//NAGBvO
	9ydQQjqJFnEiChDy5tDYpQFP5sa/Q5G6r8ydcjXnbzfbJt4x/uXc4nEKBxyOJbRNAze7Wd8Q3DH
	6yJyF5yp6tCXc/srKmLWAPhUJsjBfT54IzR1ojT9TAK0Yy8J3aWqU8LzTAkkYKMFlAYGyAt/sQL
	Gj7iIT7t/VPqXnRBOOIc6l0kPKwURKoH+XJpUKGXp89Bv+fFe9gLqGXcHXw8wkCvlNs6GxRXvrh
	roFibkBj7G6RCJ9/u71h3fl61wM0qgvUXCpkLFF92eRF9F1MRewPVXGRc9ewsO93ND8JUg9Krw5
	yThoe9HiCpUyvcBFN/H/j9vESm8lZzAVpVW1QBAG8C/rSQ04VhTuBZp14/bSRn3kQC
X-Received: by 2002:a05:6a20:568e:b0:3c4:3321:4ffd with SMTP id adf61e73a8af0-3cc2ba30e3fmr148565637.20.1786413023483;
        Mon, 10 Aug 2026 18:50:23 -0700 (PDT)
Received: from localhost ([2804:2bf0:60e7:ae00:4889:4c7a:30ef:52f7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec68468sm51389624eec.31.2026.08.10.18.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 18:50:22 -0700 (PDT)
From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Date: Mon, 10 Aug 2026 22:50:18 -0300
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCHES v7 0/7] perf build: Add target to install devel
 packages needed to build perf
Message-ID: <anp_2l7RLb8UT8Kx@localhost>
References: <20260811012905.14742-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811012905.14742-1-acme@kernel.org>

On Mon, Aug 10, 2026 at 10:28:58PM -0300, Arnaldo Carvalho de Melo wrote:
> Hi,
> 
> This series adds a 'make -C tools/perf install-build-deps' target that
> installs the development packages needed to build perf on Fedora, Ubuntu,
> Debian, and RHEL family distributions.

As Sashiko doesn't yet send positive replies for a series when all it's
patches pass, I'm doing it as a data point for human reviewers.

I plan to use this as leg work for comprehensive CI testing
infrastructure like the one I'm putting in place for pahole, with
coverage analysis that will drive lots more perf test regression tests.

Best regards,

- Arnaldo
