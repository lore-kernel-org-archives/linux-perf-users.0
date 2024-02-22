Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78E156E4
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Feb 2024 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708571259; cv=none; b=gFfIcNB933HMDle3zFSGNKrOhm4w2Z3UI9WUW36IEoNZFtAeV0860RkWeABa6T1IOIh+64hXe2R1iiQJoA15FjdV2KvwCFj/VNWy/FlURFburuyUKCEX6uorWT11x5KS8nPze93GDIY267MEcTHrLPwdMVAikB+WMXzU+FboqdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708571259; c=relaxed/simple;
	bh=UabPiaAmMwydJjTXsv1ZMVcE7S3OTCfsgnAax3slu6g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tsx1gVH7R+ZCFU1xeUMm0IrsyI09Fpq73SeTXfGVqpKuihd5D3qkm0n3lx68WgE7+NWFMrvjTuLJX2OYidNsHc0zEi+QEBslgKXUh3xiyATHJDRmc2iRSvCUjSFF0G88A9UB8m3irsAA1I4V2765cUhC7be98V+bQr8mWgi4a4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JQrfPsKc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JQrfPsKc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d5ce88b51cso73115ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Feb 2024 19:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708571257; x=1709176057; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UabPiaAmMwydJjTXsv1ZMVcE7S3OTCfsgnAax3slu6g=;
        b=JQrfPsKc/2cS63UlAB8oJAWh3MseucoLVorBhhbsR+LjmXAl/jOxd6Kpp5tpxSpnPm
         c8rr+FBcIkLZ5CUIA0UkZp8mpmvqHjKcP3OuX2WH7HeZMJqdyyaSBpW+wDH/xgSU+SkC
         R4vTSgXjtoVFaTuErtywqAUJeWErjmqgTrxWMr/xDmo6GWuQfSX33+o7aJW5p1Fo+rwF
         2biddAMVHVT3GfWk5ysLflkn5uLbj2JBw2FjXwUsW+FL6wIaegXabecOP6XSaFUvT/jx
         MV+wn6PEQP/9Q4KtENQyV6GFJJg0kgKlCOur3AtZh+OutZSY/0GSpqjWHZ+5PFPkjk3l
         1xFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708571257; x=1709176057;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UabPiaAmMwydJjTXsv1ZMVcE7S3OTCfsgnAax3slu6g=;
        b=G6zbd8du75i/2CUv5FhDCefNeuh9eCdEYSvxwDBhpJYXYqdXEIn83eqz7Jh/FREgxi
         KhWVaMghyn5fxsD5ky/vgYro7yMsMu5wAgg87XC8PhGKpO4e7LLkDC6dbqjA04F39tOI
         r8ILuhhxrAr0rKAZPANjv73EznATT64S5euqT6QMH5LKllK+7uRVk3IB3UG0jiZ+koUG
         JI5WbomO+UXec3Wfyav+pieWa0AB+w+whZ8Hj2OiPJl1SNM355mAdDkWCF8A6AuNl7Eq
         nJZGf5iqUhYEUXJlh2xG4pU5/eaY5Nrkd8JfNM/wmIKHus8yBaQQpUGyuioRl9ska02t
         s4PQ==
X-Gm-Message-State: AOJu0Yz50IiKoz7Ab3AbNIObA8FGEYTTdhcGaFPib3HGdI6Fy9OuBhWz
	6hIw4SxRBSudS7rJNfOahjDXD6Y1xepihYF5slg//zwmZKf2rOLdbr88bCjCVybiVjvzpKdZSiV
	jKGuDkj83aTM+H6BXNPfVdFF7j5GRSE//mEB8uNVYTyk5mgrYRoJI8pI=
X-Google-Smtp-Source: AGHT+IGPRh6Rpnga2U1E+7RoJn1TcwGm4/2TeSdivy54czM/Q0G7ZYBd+jX2qZHIErtNTC6IlMHgPCW9fVObEqyfRuQ=
X-Received: by 2002:a17:903:784:b0:1db:90dd:2939 with SMTP id
 kn4-20020a170903078400b001db90dd2939mr353884plb.23.1708571256782; Wed, 21 Feb
 2024 19:07:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Feb 2024 19:07:23 -0800
Message-ID: <CAP-5=fWALQGhqNqh+hsEDZ9p1O3uS=0T4_hqx-fz_VNQF96Zzg@mail.gmail.com>
Subject: Google Summer-of-Code 2024
To: linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm happy to say that the Linux Foundation has once again been
successfully chosen as an organization for Google Summer-of-Code
(GSoC) 2024. This means we're looking for contributors to do work and
get paid as part of the Google Summer-of-Code program!

A full timeline is here:
https://developers.google.com/open-source/gsoc/timeline
We're in the part, "Potential GSoC contributors discuss application
ideas with mentoring organizations".

Project ideas and more information here:
https://wiki.linuxfoundation.org/gsoc/2024-gsoc-perf

Please help spread the word, volunteer to help out. etc.

Thanks,
Ian
