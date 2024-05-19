Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DCE6DD0D
	for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 21:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716152473; cv=none; b=fc5OXDLomnEQSoi+vQrVn1zlxBxJ3e/4Jbophtq8ANFXWMNxF2aWM5vCsxyKgguR7I9ephdnyC/RoK/+pDhwPp7e4wTFoP0/umwsB9In84jon3U6fBEMXKcojlYiGhMT2+pklPFS7SiYF5tju4NHZrNzHCtgDokZBSNkiFUbW00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716152473; c=relaxed/simple;
	bh=/Bph7+K9Jkj+NTdSMK7OBzJ0wyGXSdYBZ9WleWfjtmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jpnhfEFCqalFlgapS5ipGX78Kz30EyQM38E876jumukJWmVUVTa3tY0j9KU/dzGMDxERIUpm0gIgeglYP87GBv8N/2R/Z0k4EGNKbbQcxmYHJiWUWCO6pnys38SMBLPZVUgF+Y+KN5qIF5uDf6RvrcoKhLt2lWQyq4LHwgrVXtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHg9kvrd; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHg9kvrd"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5238fe0cfc9so2011643e87.0
        for <linux-perf-users@vger.kernel.org>; Sun, 19 May 2024 14:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716152470; x=1716757270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHS+308itLVHd7M3dYFbOfs9US5TMAl7Ail4GLcbRQY=;
        b=rHg9kvrd8doUAiD6pghd894FCoM95U/J0jxnqacOpm6MRuuiNoc/hQh+W0EZBi636t
         MG1LCK4lTPWs05FnEmfWZQIFofFGGiZnoRebeFFqLUyzX4zyJ9DnN7ZcQnflR7c0cFqU
         Q7sUCR49MDc8vFAcbLvWBoJ/d+wroocp0VGJG9C4ZWHjWsSt9kqpHi67yMCf7vEDDGhl
         6jwnHaE0V6FMkV2ds0aTAV+KP6oNKgTMnDPFHtnNbaoXnlibP2N3+FX0aqCU+wdsj2DR
         tEyNZxPBVdzNkyXoESHBLoNQ1yRUiTr617e8cJ6PrcFXs5z6Ofp+Zb7uHUTY7L/AKsKW
         XY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716152470; x=1716757270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yHS+308itLVHd7M3dYFbOfs9US5TMAl7Ail4GLcbRQY=;
        b=ING2kNMuDnojZ9brvj3LJqWQ2HBhjA3bj8ey8i8Ze5QxYV2Ekk8NNC0QOUkdf+Eyip
         wBFpK541q9Y9CKtAm3II+WU6ynWpipiYeSXA9+aPa+Je+PWS+15UTsHV3RYGuchFIEDv
         1Rvi4bvecHsq5ELnLsgQ4y4nv8unNbIAZTvWLeSRGnsBNHlPlU2LnTXqHGyUKJg88sx1
         U9vb+3E+go5JHOxK3+am1gMWbqdZ4MrZF6I5UouBCWBsfeMOzm8U3Js5MqkEAk4yWPhT
         hx22PO6lMvFYpCBYrfJYSwQKOdN7X+3Ox5FdIIOHqws5i4jhJl/BRundhgeNxRaA5AZd
         0t1A==
X-Forwarded-Encrypted: i=1; AJvYcCXM34ok/KBioIzJRw0zq0wU7tpPoE2cSjW3natx5TUMBK0godXQ6u/GCT0oj2iBB4XjNBKffSfFNNojTlGOgGsFY3tz2N3Riiktw3ns7U0Acg==
X-Gm-Message-State: AOJu0YxVFMPJhLlLZ/4ZHNOoGWEH4xay9GWjXtzlZi93hm0sZBDliXJl
	I8ABIT59eIF7fv9vYaHIJOCGiJtUx7hROzzmbQRIBeoOg2irLqQ96QfJaJd7U2KlXWddJWDPHDE
	LDQ==
X-Google-Smtp-Source: AGHT+IFzuf0OobYCCdKZZSJ9VsFix5Zsea7N4HzK7XLf1RNV2+5n9LskFwgvoInAbQpnu51OUAkyMQ==
X-Received: by 2002:a05:6512:1310:b0:51f:3f6c:f7d5 with SMTP id 2adb3069b0e04-524079b1f5bmr1431406e87.8.1716152470068;
        Sun, 19 May 2024 14:01:10 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:9677:a1ea:4905:181b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52426a16831sm448711e87.191.2024.05.19.14.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 14:01:09 -0700 (PDT)
Date: Sun, 19 May 2024 23:01:05 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZkpokaHRfQYCo3uG@google.com>
References: <20240518165335.3963530-1-sesse@google.com>
 <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW5YtzYz0R-9ZkgfdAFjkUDHu_Z1Sexs+2SmN0RwhrADw@mail.gmail.com>

On Sun, May 19, 2024 at 11:23:26AM -0700, Ian Rogers wrote:
> I think we might want to display this in the feature list during the build:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/build/Makefile.feature?h=perf-tools-next#n123

Ack.

> s/HAVE_LIBLLVM_SUPPORT/HAVE_LLVM_SUPPORT/

Ack.

>> +#pragma GCC diagnostic push
>> +#pragma GCC diagnostic ignored "-Wunused-parameter"  /* Needed for LLVM 14. */
> nit: pehaps disabling this should be conditional:
> #if LLVM_VERSION_MAJOR == 14

It doesn't seem LLVM_VERSION_MAJOR is defined yet at this point, so I
don't think that would work. (I just checked; 15 has the same issue.)
In any case, I think it would be just more clutter for dubious gain.

>> +       if (file) {
>> +               if (line_info.FileName == "<invalid>") {
>> +                       /* Match the convention of libbfd. */
>> +                       *file = nullptr;
> Should "*file" be cleared if "!file" so the caller can reliably free it?

I don't understand. If “!file”, then file == NULL and surely accessing
*file would mean a crash?

/* Steinar */
