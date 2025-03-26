Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FC11B3950;
	Wed, 26 Mar 2025 16:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743005072; cv=none; b=XZCzP/r7oi3UImNFnUxSBiv2r2b43zavUtysGWOLhhipfTJZ/1/W3RimsiNgyvmc76pzZArGqjr4+nPkDNS/qCWIi5QgkxD43bzhWN0MKr0xRFKS1FoiztWteK3WLWsaJk5hXIcioI7pii3slUBikrBDp1ue+U9zlMZU3CvPVR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743005072; c=relaxed/simple;
	bh=/hqzhHCMaoF1ikFlSDbqGo7f8iTiieN/aBvX4e0gdgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3EHEtDGNY91tN/G6voVTTRdYiB5xWlCAwM4cXw6QhhZ0P3l22qeQP8D4lrit4LRcKvp2AgkLf2EWjEOWHM5pX//v6Ph3XwfI/q271ncSbBdWd5fB1NWvjD8128K0Nz15Yn6SZMzHnjdr+uOJMoTbLxVRzFwkpzcC7NEvK5jW/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emp9bxV5; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emp9bxV5"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-227cf12df27so392855ad.0;
        Wed, 26 Mar 2025 09:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743005070; x=1743609870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DCL2/LCom/dIJu/gC9WnHR/cpfIuT7F4DmmxpA9R5hg=;
        b=emp9bxV5sKoV8tgGou5/uNBSwgDzz5AF8DyweV/1y+RBhrSeh9z//qNy7/X2xg7pvQ
         CDGtLp+zDEreufn125iAneRZZse7VfEuRuJ754++zW+rzJ6AMu2kXeIFXCQjx5aUdYZV
         7O9fUinZK59TN8XWu+e6f+kLOwtWyjRH89x88yp8QsB0XFg7uFY7bi9GUJBc+d5YUnOT
         89Yw49X692qBz54U8wwRoT82zxIglSv9ffz12tUKjFpn4L9npsYzMIq8QNnAcfuPpq4u
         k+lQ/jFI8T+BZi2SUJrE5SIOmOBqheF8sm9rN1NCrZVWwKaj7IzB/JAWl1CwCBAUREb1
         TqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743005070; x=1743609870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DCL2/LCom/dIJu/gC9WnHR/cpfIuT7F4DmmxpA9R5hg=;
        b=sQlNGmPKEQsBxbV7W5Z+CAGHGIketESK0WaZoVGO8/cIySkBbXj8pSDuLnqZU20dq7
         ErjISwL81ZFOmVHUMkmF5K1SPZIvQEFmhhXW0AlyjKjJjjzkBqJ3P9NJ63bMjtmjYihb
         ROVocuragQAo+Xjd64QMuu82hjm72bHc44iFWGJqj1YB6/6868CnKeK0bJ0a+lm8Zi6/
         c1eHKwKXm9LwCfP2XnCAdZJSZIz1XeA8KS0g0Gjvzw5SwUXXeJvDK1MPAeNI1g2Oxqt5
         9z5E4IuA8nNr2tUTsCB2Q0rAJtL7bWyGTrondWQgrwKWPfW84Vs8yemHoq4HAsbyIyii
         e1wQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8OmZbvcs3nikfnVDJM7sxU7zljB71D62mFRkZZSQ38ACXloCtlFrex1gnPBXMSJsTmCMHlooZG7MDFT4H8yLs1w==@vger.kernel.org, AJvYcCV7bHkXhuYONI8JsbfnEOWKWex7bcZSd3GU375Dozv3hH8fmjYNkpF6mfNMKYqgLKK92EodiSXIpBBP8UU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZBFfaPQlOCSdJgMsgXWGXr7nYWZu+z00V4DJw3dxH1NgeO12Q
	Z/gPF7VwNbahE6I0kB6FPNobt8cPejHxgnwPEoeHw5CFRl8vst7t
X-Gm-Gg: ASbGncuH6OCn7Jdw7MXtfm7rAikj1D9t9cWa+XtJUfO7dVdM17PGlYMQysMM194sCyx
	g0fLpC3yV64E2FjQn3gxw2+7BAnZoXNg8bB1Mn1NysthCc8+YObfCVqA7nMIV0fE8Xux0CEVHSf
	HWxlkzfdjrIc2IPdsymdEF49vvb/Wi/2/Ea54UNd9w5+oNeG9Er0Wuq7NQmVxYnFwX38irFzRB8
	+BmOK7aP4b/S0yi3f3D5gwx+rky6AWuPj63CszjFAw6LQCtG2svFOhVyKryB4i6p6eliHwvmE3w
	RUBiEftzHAc7JRKSdL/ZyhcpPQQ91LdpEmwUjzPVCPeC97Sad2bkOWD4cblhIBkK6HP8++Td0rS
	55cNS
X-Google-Smtp-Source: AGHT+IF0QK7H6xH2o6TwkMOq7tw4dHANmuQTSlCxdvxV/vO1e0iv4BsdiD0tfK0QqdMnQsy+ltpB1g==
X-Received: by 2002:a17:902:d549:b0:21f:53a5:19e0 with SMTP id d9443c01a7336-227efb041f5mr74046565ad.12.1743005070296;
        Wed, 26 Mar 2025 09:04:30 -0700 (PDT)
Received: from howard.lan (c-73-202-46-50.hsd1.ca.comcast.net. [73.202.46.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811b2b07sm111370645ad.123.2025.03.26.09.04.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Mar 2025 09:04:29 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: mingo@redhat.com,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	peterz@infradead.org,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH v1] perf doc: Improve perf trace's doc on --force-btf option
Date: Wed, 26 Mar 2025 09:04:16 -0700
Message-ID: <20250326160416.1725322-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As mentioned by Arnaldo in a past discussion (Link:
https://lore.kernel.org/linux-perf-users/Z2m0pWiQgZNXhvxK@x1/), the
current documentation on --force-btf is vague and inaccurate, this patch
aims to provide a clearer explanation of the option.

Signed-off-by: Howard Chu <howardchu95@gmail.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
---
 tools/perf/Documentation/perf-trace.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-trace.txt b/tools/perf/Documentation/perf-trace.txt
index 887dc37773d0..cf2445d2ba3d 100644
--- a/tools/perf/Documentation/perf-trace.txt
+++ b/tools/perf/Documentation/perf-trace.txt
@@ -246,10 +246,10 @@ the thread executes on the designated CPUs. Default is to monitor all CPUs.
 	arguments to strings (pid to comm, syscall id to syscall name, etc).
 
 --force-btf::
-	Use btf_dump to pretty print syscall argument data, instead of using hand-crafted pretty
-	printers. This option is intended for testing BTF integration in perf trace. btf_dump-based
-	pretty-printing serves as a fallback to hand-crafted pretty printers, as the latter can
-	better pretty-print integer flags and struct pointers.
+	Use libbpf's btf_dump to pretty print syscall arguments, utilizing only the debug
+	information from BTF. This option is intended for testing BTF integration in perf
+	trace. Using libbpf is a fallback to perf trace's own prettifiers generated from the
+	kernel source, as the latter can better pretty-print integer flags and struct members.
 
 PAGEFAULTS
 ----------
-- 
2.45.2

