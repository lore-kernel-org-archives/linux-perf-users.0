Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F01181CEB
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229791; cv=none; b=T83hu8c6ZurCrLJ6OBSn7hZsRsemA8TIlsxCbFsoAS76q4A/F8JeNA3wNeJQaZkTG7vdEK0Fb9dEpZ0dMr7Y30yw+WP4G2ok1oF+nKOMiWQOZdVsO+KmBx54e+kVRj3tn4m9dIz3mk/0QqRTwOlXiLQTHvSVp4grrYjzoX7pxyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229791; c=relaxed/simple;
	bh=2uUzUI45oTnm6sXU/3A+RvL1dLhC3gg3sqx7aB+ucus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k5nf53tScJUOsesrnlqD+W5QiRl23sqj0GHqwYgPZ+9/Qf7jva+QNmZ06i7Z6RN7qouZV7ELzKHEbJX/kQz76FUawHx+9Vl3zh2CEW7RWKGts/w9W9btFlj6XMo1Zrc+HCBGvJJN7dRud2MZPY5J07YM9tuINR2XsDZUdERHGvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NNLxIZ6T; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NNLxIZ6T"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-38206c2f5e3so139335ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Jul 2024 08:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721229789; x=1721834589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iRLHKzItM20H7XSXlQZgREwapn4lm7JLNhhvUHXBIA=;
        b=NNLxIZ6TpOiKOXgxwr91MU8Tcz/gvNlgRWDqhNROArWTassjBqQ+RZcKyI7PdfrMU3
         yWXEYsK/wPAEvWyiDAUnHiPyZ5yA93YtgLZyPqyWgx8heytps7RZ+H5vwFcqd8ADFNLh
         sXkEYYLg2DMMvilEk13K1uhhVK0GRS3/wHj1WurGnPurJElMwdiGEoQI396SG1ZUAMbB
         KD/jvhaN1Saje3tTj4ZwSKpOCrzE8rewG9K4KD9qDTkjklQXE/bhlNJMPoIMIIwA/MA4
         Ylug56GRhkt7a2NrS3sowDUXsS5SChN2Dcw7LWWwCJpOLVGZ9ztBOCk373xhan+0MQcd
         cT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721229789; x=1721834589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iRLHKzItM20H7XSXlQZgREwapn4lm7JLNhhvUHXBIA=;
        b=EZPo9Wdr+1JyueFO19rNxDtJfDFNzi94xRAFcBTIHriSdYkLM6fT5B7P7dckG64NH4
         oZ8DC5kLic26MORHBaa5bPFvLH5dUPOZS59g8ilU4FsjU1eh4KONZ4I/BBhOypydKaYf
         8K3kIPgLx8JWmjlX8zaj27LGa2cSxB1sSjoKgoaObgYb6Hw8sgHuyyrP/P2MXDIde7ek
         lGUAF34Svvmy9OCQ2VZ5SAXhb8K2s9rsqkfDiDb2t1kOvHgHHLnQyvbE34vV1PEwdIp0
         1fEkzTrj1XdTDk5VBRkZ1PAL5hGyemPr157p9kQ3QNnVqsX4MQGCx2vT85ng+Ie1M3+X
         J20Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKOlqYOT3VhxScTe44uRprdw2CX+dO/PyfqgklIlQfz/3/rqTc2P4h4iY8LwrFl9MMiwdKbwDL/R0247HFsA0PoPzhv4L+PjVkQiogxNwVPg==
X-Gm-Message-State: AOJu0Yzm34HEersLEgj3fi/XrE6qwtMBaE06w1HmQwCoaZ4j05KUPn30
	Ti9dOlNxg1apqx+OEz5XyGmlVuFQFgjSBB2pwkPr7Lo6gr5Tbx+ngt+wwG/ekE/ppRyDT3eSoLc
	2qxcQGQwrwgfzKPvpEnJOWYWQCIJaP7Bbo0DR
X-Google-Smtp-Source: AGHT+IFT2y/sDTIlBGHR8EoRgqXZAbbNq0Z4632Y4MppMRrjz83PHM2cGFfDcvuwyep8nnVsDqauOePmYcWdIerzBf8=
X-Received: by 2002:a05:6e02:1388:b0:377:872:cf6b with SMTP id
 e9e14a558f8ab-3951364ea53mr3776545ab.2.1721229788751; Wed, 17 Jul 2024
 08:23:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717082211.524826-1-leo.yan@arm.com>
In-Reply-To: <20240717082211.524826-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Jul 2024 08:22:57 -0700
Message-ID: <CAP-5=fX_h9ySEDwN8EWLdE2X8c_LivjoGd=7+aT-X8W_RdwcyQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] perf: build: Fix cross compilation
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, James Clark <james.clark@linaro.org>, amadio@gentoo.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:22=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
>
> This patch series fixes cross compilation issues.
>
> The first patch sets the package path if the package configuration path
> is not specified. This helps the compiler to find the architecture's
> package in a Multiarch system.
>
> The patch 02 sets the Python configuration path and renames the .so to
>
> The patches 03, 04 and 05 fix the static build failures.
>
> The patch 06 adds document for how to cross compile.
>
> Changes from v4:
> - Polished patch 06 for removing redundant sentences.
>
> Changes from v3:
> - Added more completed comments and logs for PKG_CONFIG_SYSROOT_DIR.
>   (Namhyung)
> - Didn't include the patch 07 for "perf docs: Remove the Android cross
>   building document" in this version, which will be sent out separately.
>   (Namhyung/James)
>
> Changes from v2:
> - Reordered lib paths for PKG_CONFIG_LIBDIR. (Namhyung)
> - Verified the Android NDK and based on the testing result to remove the
>   file android.txt. (Ian)
>
> Changes from v1:
> - Kept the cross-compile-pkg-config if it is available. (Namhyung)
> - Removed the patch 02 for fixing pkg-config path for libtraceevent, as
>   this will be resolved in Guilherme Amadio's patch "perf build: Use
>   pkg-config for feature check for libtrace{event,fs}".
> - Added patch 06 for document.
>
>
> Leo Yan (6):
>   perf: build: Setup PKG_CONFIG_LIBDIR for cross compilation
>   perf: build: Set Python configuration for cross compilation
>   perf: build: Only link libebl.a for old libdw
>   perf: build: Link lib 'lzma' for static build
>   perf: build: Link lib 'zstd' for static build
>   perf docs: Document cross compilation

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian
