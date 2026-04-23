Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203653603EE
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928038; cv=none; b=WnrukwsEZrGieK73VPgo664o0NXlt880isR3+KzojG9IsuYpBvp78HVFFA5PdE0E9YJg9+I5GvDQqz7gHLJjKS57SNc9dUQP8c5lotgCrlIh1BcrlmWlkO4pSf0dnGBKDBJnEe6HZ2RaANvaLKxcUe2ZxvwoGQDhTGNp0mnUq0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928038; c=relaxed/simple;
	bh=ZsYZVWSRpYjND+seai8PJAJvodVuBZleUViz9xE938w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NZkMRcaatdlDyUzKIPIScNvRKKb+ZpupKrtYXWyZsCHFgxO3dz4cPamsmG0VD3NOt9UQJ7tdFDTCDvt9495rCX3Jv1aJpfBTkTQjIrYsSgGiRI6c4W4eWjdHkVnTytkRwW+8xAqwxfbIYWhp90jYCb3QY4Kw80yPZ1z1vEsDZrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsBNZYCl; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsBNZYCl"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65318dafbcbso6429472d50.2
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 00:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776928036; x=1777532836; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1Rv8LfN37lFeKpCNjjDsd/mT5lAqzaOO1E9Bkiy8MM=;
        b=BsBNZYClM0dZ/j/upeb7WypA0oNBk199Y4/sNJ2aZyzvl8ku6NaPkU6s2pDr7/VqYZ
         YIN1im/pCzgk/aSJ8OQLUA1aD2WawcDSzArX5ZZMJ8X7mABphupyyUW7mAafUx4jS9Bw
         XdFg43uAyJW0gGpd79s/XmKxQpb0WvJArnCCNsbuNtx5mnS6gFc9tT5z6dbNWBgJaY0+
         2CXXXVJdI/eSN455ZIzz3W3MINSvDI1XlHtmgySmlA8eN5C/4skwDytHdx3NmYfZML9h
         HIuiEcvLGDi/3mVLAbW/Q5ZvNLxbFG3KSRV9YB7E3WyqYW3U7DgOUrqzLlLkBAOH5u/2
         CPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776928036; x=1777532836;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1Rv8LfN37lFeKpCNjjDsd/mT5lAqzaOO1E9Bkiy8MM=;
        b=Z7zzSHOZdAht10UeGxQFE1jGZw165e6wJ4s2kXekOGLKlSwe0FvOFe2sVX33wmxlBD
         8zwY/vpwL9yF2TFQcSOl9zn7isT2ezavCk/2/CnhIHHfGLoN6PTMFFGQ+e6rxWS+M6TD
         DwK3cRBuflFvLgF7QMOI9koouo3dOQ9lDFu/hUnpZDhX3repyyFFRJCdKb+p56Lk1Fuf
         SmHWllHRivGVLvRKLlNgOY49qUejqnKJ8Vpxydnv0mD2RVpJ2Gmq7eOixNA6XZfwosdv
         h9Sn9U9FqzPTk+BJKjxQ74b5tZpJ5ko7ENutWTMRcJfavQ+hqGEn46yOxiO6GyVSl6Bz
         xJFw==
X-Forwarded-Encrypted: i=1; AFNElJ9OrGWQZVpegmBhaimK7Is+E0WThR0I82hWezEplD8dWWv32qEwn4VQyZJqBrLglioSDeh6hqb7QIYctm/Qj5vQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwidFFmwNcW7YyNU9pWg0+YGOi4tDHGID4d53b2UyccCR3EiXQG
	CntschY/P0C5tevkjq3sgl0VTkN7slkZgFTCOGqIzp4DxCugBgakoadp
X-Gm-Gg: AeBDieu6EKupTN3/LrVcefVDFaY7hkskI0C/5S1cnjJP8F0sePkEZanJJwyggYyBfsI
	k79gDpq63vRiub8j+J3ry90tFmMQ1fClZof6KBEg75m2upLZM3hO6yTGJhRgCHg2t/mZfA1UjC9
	vLCfXWzS3RFClSyA3smHKhob3sXW6xVTKKs007h9OQE1+9vgWrmDoEwZ9bTwppOtfitueZbuyHx
	958m9NW8VAZSix9eNl082di0fsumawwxWl3qj27j59KcCjCvWgAKZ4QtzRZGX+FZToZMhC88eBp
	nM5uHAzf/OpXrwDh1NR8gUVd2aomWCCV/SGQ646yFWqEzIJZEOcDIyXj4aZVSbPEgMYbMs+7GLF
	sUennVGpoix4sKFeoPpPkfETjK8VrqYtfNQn2zchQNLeiRzWN/Rk0J3JtJS6h5HbdQCcsM+vFZ9
	7iEnMEizfRrPFMZ2waIAnG6OZ3/lEs
X-Received: by 2002:a05:690e:4199:b0:650:1d3c:2ae4 with SMTP id 956f58d0204a3-653108350f9mr21476505d50.19.1776928036181;
        Thu, 23 Apr 2026 00:07:16 -0700 (PDT)
Received: from localhost ([172.216.252.33])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65314b7d42bsm9178674d50.8.2026.04.23.00.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 00:07:14 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:07:07 +0300
From: Dan Carpenter <error27@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Guo Ren <guoren@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] perf dwarf-regs: s390: Fix an off by one bug
Message-ID: <aenFGy9WDllTEO0S@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Change the > comparison to >= to prevent an out of bounds access of
the dwarf_s390_regnums[] array.

Fixes: 1e452dd850f3 ("perf dwarf-regs: Add S390 perf to DWARF register number mapping functions")
Signed-off-by: Dan Carpenter <error27@gmail.com>
---
 tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c | 1 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
index 310a37451bdc..f79216a7665a 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-s390.c
@@ -45,7 +45,7 @@ int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum)
 	if (perf_regnum == 0)
 		return 0;
 
-	if (perf_regnum <  0 || perf_regnum > (int)ARRAY_SIZE(dwarf_s390_regnums) ||
+	if (perf_regnum <  0 || perf_regnum >= (int)ARRAY_SIZE(dwarf_s390_regnums) ||
 	    dwarf_s390_regnums[perf_regnum] == 0)
 		return -ENOENT;
 
-- 
2.53.0

