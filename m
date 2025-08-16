Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814563176E8;
	Sat, 16 Aug 2025 06:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755326780; cv=none; b=UmK7UcjhzicuMo4oU0ZjnrFmcd0ifzNwbt5aaKQ35aSeB2/xA6e0wIF8+HRwKTv1J+cUC5Ye3OQjjElodVWjlRfmKzKOzjAV00gT9Rj1vW36ncZl0U3Jpl63ugZh9Rn5R05ezVX4tGx/0KXYEYE3i+vCKToYSubauiG/pBJJ1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755326780; c=relaxed/simple;
	bh=gAvOBrY5es/yKWkDs7Yk9hOG49QFhgslkJsBwv3zr0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rB8ALoJqu38K5jvVkWjZZMzBTcJMls6bulOxV+OMGtZ905pFHiiWJzcqWKF8mhW5w/mepV6PybT+mZwHlWpPjDlJY25fntLRVSBllCc25jUTdJDk7QWfaLEDNQm0bKFNGGV3VlIMh2Q1IYD3ooUUbXMzMo05AddAsPHzJX+35bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtMrVXM6; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtMrVXM6"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-30cce5cb708so1817355fac.0;
        Fri, 15 Aug 2025 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755326778; x=1755931578; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAvOBrY5es/yKWkDs7Yk9hOG49QFhgslkJsBwv3zr0s=;
        b=dtMrVXM6kPB2hN/CJGon7DcoY5f5bE7qDG57be7Vq7NAk98eos0aKQ6lbm+eGS7sdk
         LKpBeCFmlXnKRsabH/AuL76Rn0+patLDHeGwkFYCvfEBwIIScMAaV1IMkMGF6G2yMDA8
         oWYVfGUV8K1r2K20oMO8mSoy/dItXoEdcvw0yDt/N2ou4u8sqpnG/G2Hbt2FXSGtrfM+
         Et4OMaWQdbv813BJZwtgtTHAXAJd+3o+y1pDxTH4PK9Af/N2sJIZp1EgGhuuT83CcQGY
         KiU9H01nozKEL8cEt/rvMVHjycJ9rLUA52CtdBDlA6c99rRz9ZTwSk+BeblCeu5YAY7k
         PNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755326778; x=1755931578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAvOBrY5es/yKWkDs7Yk9hOG49QFhgslkJsBwv3zr0s=;
        b=SFUcq+0TeW0SIwlmfFFJXu2DCpbYV3aeuuUq/Qux8DgCz7THgqhsZrmKHr0/CVnjAJ
         3Qwkx/ay3ATCqiAGcyq5fMLxYEAuoTQFH7oVQbFlx6OKb6NptzERSz5YbQvXlp9wlnKQ
         /OT8cntCcoigMgHuQpHfyQFbST/Kp+K+X8dtI1J9bgXj8rUqxxk6TDoH9kkOcG/gAnvc
         EdGbdmvLnFHhmydZamJcBaiApZvE0Py/uL/lDceWFhEVQb0qDeuIg0zk7UHbXxh84ZhD
         hyf8U9l4SA3CqgnB1YB3Rq4B2GshhwLrrM0AoEg5j0qx+dUfs6H0YRuFSoWGWiQp6gMk
         tkJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzJ+jYze/hzCpvZX/nzHvT7hw/ms64a1BrmtKUqKxngGa1LE8F81UxR6oAG2bektZ5vlUMiYQshOigjSk6@vger.kernel.org, AJvYcCXGafCDyqCaYL8+eEyBCX9HHCO2EaMX/MiPDS7MaUfEvqL4yi0jNV0+YTCB4F0cZ5lDuvQr/gYCtg5q@vger.kernel.org, AJvYcCXq1IFteHt2G3WcXWBBJzvTHxXK8IMpAWMBnPKV2JzXZNB3z9HyQHYsYSQ8qlSG5y+Djz5l3+Wa+H6Q0WTzoN2NFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVx7NMQ9P3sRc3qIulkM3fjKDxfQinuZyq7KO0e0E6S2uq1aOO
	XKXUZFeW4El6pvuXYzcKx4LmomWRfsSP9/Xxc06g+pqg6ob2bzsau3oC3+9Q9fWFWH/P1DYh1e1
	HxEdc9eWEqD8uPifKDfMgHlQK7iO2ZR8=
X-Gm-Gg: ASbGnctfl4NoM+LMcxzgTyNpX4PvV6f5WL1mhLsfXtdkQAdOjdYPTTGsWwssr8FmqgG
	JqNCyTW/5wUVGKSbrXjroLUFsHDqn1fPQakdGB8WHKYVpLTveBpeJjg7r5HOFuxcu4PWRrj7NGn
	C0tbZqaDQUItS7nlOCLzwanA+uJqm5yvfaqIVYihoxhWXOrF3qqUVeM5ad76vIYfAkHfFmXar/+
	Fn5vpV8DqIW8pb+nIFi/xVopqmtTkbPtVGi9N8=
X-Google-Smtp-Source: AGHT+IGjUuTFMbcHoxRQ16+EoLIDzFiULTRGmEHr00m0tAm0LGBEAq+siKWzqCMyJm8+Yk6JcOtKE+H+Yf8xIItqBpE=
X-Received: by 2002:a05:6870:8910:b0:2d4:d9d6:c8d2 with SMTP id
 586e51a60fabf-310aaec9831mr3004527fac.35.1755326778529; Fri, 15 Aug 2025
 23:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815182742.45541-1-suchitkarunakaran@gmail.com> <aJ-ScOp3ZCG6PQmD@google.com>
In-Reply-To: <aJ-ScOp3ZCG6PQmD@google.com>
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Date: Sat, 16 Aug 2025 12:16:07 +0530
X-Gm-Features: Ac12FXycVXpv53_SMZYPs1lhxZFFkJf2blSiPR5TbUndixnCz2Z4HJEjGK5pwjQ
Message-ID: <CAO9wTFj7S7G2bqbiuKbR+o7Y0u1EkYY5GsHasJZLmAo5ZuCx9w@mail.gmail.com>
Subject: Re: [PATCH RESEND] perf/util: make TYPE_STATE_MAX_REGS architecture-dependent
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	alex@ghiti.fr, guoren@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-csky@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Namhyung,
Thanks for reviewing the patch. I'd like to ask if there's anything
else I should do regarding this patch, given that it's supported only
for x86 and powerpc?

Thanks,
Suchit
