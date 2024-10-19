Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EBC1CF29D;
	Sat, 19 Oct 2024 02:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729306562; cv=none; b=aaILDJCnumuy+vmD2V7/WEGGxJiYoXRFEO41EdCwzmgj1qkHh5TTUBjkDfA/fZ+1NT3D9sCzsb9fQPZw+AlAwL+5BfjRXQpNbpB+99idQhlP8NrMuVSpY3Hq6eA1lMdl86rPBS747Yr0nPcD/mmRreMEyF7Be1+DLq+0vYyKM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729306562; c=relaxed/simple;
	bh=5/Q6mMEQKt/YqZpUFUqGN3VO5GRE3MysNt+6xXWT0ys=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KyZ2m9grBEp1NakdT+1oNJy4+AaZuvmNlcE8hr7qGWGWzKpInmbQh6uS2tUVu+/nDBwC1EbwT8/MQeLHeOVvy6lIczHiyBEZaGj27g4/Ygh2oKZGY53GyTfV3HOQueYWn9OrZieIAB8ggiEnNP88t/1W3dl/ZTIo1Q2jHYlLGqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ah6eMTly; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ah6eMTly"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e2e23f2931so2259419a91.0;
        Fri, 18 Oct 2024 19:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729306560; x=1729911360; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zjvn7HsbY/vgKPllNGPzOYRc5ty961DmQb25tJ1aZoI=;
        b=Ah6eMTlyVEJVvgBTYjQPgmieI7BjIh0g/awujXCY/cKljD0njNGkZp0PoOkn4erYzh
         sza+5tsyDNkwUXzaRH5iUnj58ha1Pklw6yl6ctmZQannXE9vEik7syW40EOGAMfqKg3o
         c6ZJgXnHqCNTyHA2J/I5Odx+3Va72k4eyM7g60vIpaJo1RF70TCdEmlJhHnWycyj/V31
         +IOJRCV64/oEnDXybWvrVj5ZXFtQBy1WEC+cgvdNE8jmjcszV0WvBy0bViRe6xXRkzWD
         6XHyMs/ciX6qIxMM5qbOCO8o2W2fSSKee6IsXtSDxWQ12i8uiDVpm+w+EmNp2bXyjUwm
         X+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729306560; x=1729911360;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjvn7HsbY/vgKPllNGPzOYRc5ty961DmQb25tJ1aZoI=;
        b=lO3B+WsF5tna2tzFRMJo4uYN8tVvWbt+MhpqIEmzmpDM1073QGCSvSfiT1ytVaPzZi
         GC6o0BL6zS2X9qUhqdzwgw3hLUgNxXubmkP0sSUZ2GCufo3pNQHbkVQFfpKWCpIP0K64
         HVbB24zt3WW7GAnmxXrKInHoyn5feLSaBWnQknPudo9aUDNhrU0wTf+AcXE0CNkU8N0Z
         TuSfg1X1JzRiVMBmgIQzjuk9YDrmxN3z7HCsrILPKe46i+6NRSxjtZxsQY/gvqqiU8PR
         PVtS1y/KyiVBQbf1PyIlDBD5gDGgaJSn6x2v2oZkha+tO8jR6gufQ3veZf3AzSYAiW4R
         RhNg==
X-Forwarded-Encrypted: i=1; AJvYcCUE1WW83p7wHeqD1uGtT5TS6QFEd1o+d48hToP+Ha9B1ttr5nFnVOdWSkYnYAepoZ8ZqzTQRUto3EgjZJEsAq0=@vger.kernel.org, AJvYcCVTTVgxJjEwQqVjLuefvaOv3CpGXWmFXFZh9xxPU54IGweTo8jjewKAIUDU5WOWlnQAtAQGrWkPSGQzsiXGR3lYIw==@vger.kernel.org, AJvYcCVs73llRcBxOfguq0HxYJnVTwqyZh/Q9D278ZV7UI6kKcrnIrWLkRa5PnsBqungB1ZnPEaeiPmRsXa2nyY+@vger.kernel.org
X-Gm-Message-State: AOJu0YzJd16nQHjzQW44sEyktdverM0hY6K5smAKMyoNBFPRA958C21m
	zkHpjy4lEop8VbglWya1vAZa2N8+Aklmi9Vay4pFYPfRyR/lu1/J
X-Google-Smtp-Source: AGHT+IEPqWiwtVaGplrYbUc0xpArNcC0LaqOO99PH7sLEakviT8UYNXgSidnH4I5Y7jc0N37OI9r7Q==
X-Received: by 2002:a17:90a:8a83:b0:2e2:e2f1:aee with SMTP id 98e67ed59e1d1-2e5617487d7mr5072291a91.22.1729306559845;
        Fri, 18 Oct 2024 19:55:59 -0700 (PDT)
Received: from mail.google.com (125-239-144-11-fibre.sparkbb.co.nz. [125.239.144.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e58390d63bsm522052a91.0.2024.10.18.19.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 19:55:59 -0700 (PDT)
Date: Sat, 19 Oct 2024 15:55:48 +1300
From: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: paulo.miguel.almeida.rodenas@gmail.com, linux-hardening@vger.kernel.org
Subject: [PATCH][next] perf/x86/amd: replace snprintf with sysfs_emit helper
 function
Message-ID: <ZxMftFRJ1b91KbRV@mail.google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

sysfs_emit() helper function should be used when formatting the value to
be returned to user space as per the documentation. No need to replicate
logic in sysfs .show() callbacks.

This patch replaces open-coded sysfs_emit() logic sysfs .show()
callbacks.

Signed-off-by: Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
---
 arch/x86/events/amd/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b4a1a2576510..bbada8e3e491 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1346,7 +1346,7 @@ static ssize_t branches_show(struct device *cdev,
 			      struct device_attribute *attr,
 			      char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", x86_pmu.lbr_nr);
+	return sysfs_emit(buf, "%d\n", x86_pmu.lbr_nr);
 }
 
 static DEVICE_ATTR_RO(branches);
-- 
2.47.0

