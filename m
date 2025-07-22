Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BAB10F2;
	Tue, 22 Jul 2025 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223792; cv=none; b=hhrHe6wF485CR25aooUIdr/Wjx8U2EjorUP2eUn6457nJ7E7yWsZQkRr7Yh5Ur5ewL9ngoS9kcp2KP37YIQQRf5BqlypSR2GElO0vDxrQ/ToV96ELwlhzEfVqYitOILErhIqZ/W9muzZ3GvdaGkTx9HMyhqUbV+qq1lwQnqroR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223792; c=relaxed/simple;
	bh=hMI0nsOW00t91gdZHOJGLbhrE7TnL+1bESOMcvbzRjE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=jUVLFoP9jldC0168m9tdaBG/2PBJNBRCpLew52+xoZ7pOuN4BUYCJo1XVSRW0Oa0iwhVVl6pMMqnFskZZu6oVoN0ayRdT+FC7g35bdAmrdxjQRtMVfb70GyMwesRdGWLZUOWEkSal40Le7NvaZqZhCZPgBSFs9ayMc+6+hEXgF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=grlAPyxU; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="grlAPyxU"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d9eac11358so586959785a.3;
        Tue, 22 Jul 2025 15:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753223790; x=1753828590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TBB+90UYLZMUNkM8Iop40n+D0UzNuJmPLssHgoedKC8=;
        b=grlAPyxU4wh7T6Yk5iyTpxIhPSXmUdODkfXmUD0cNV+yNVHZCzxbYfJgq+CDh7FcWy
         9NpGRus99NaIItis2j+c9407spRmpArnAgTiqJNVfanpoz3VzyM7jFnFnhjoBdsei8EJ
         iJOmpL2ArdDzZFBJ0O974EU0KlEhq4SVtFP16Ql/AkVekKPxLTWIRuzDX9ufSzsrhPX2
         Ujpe3xC/x3cI/I5cdAOtpMI8GTE2uhnNKow0TqdyRS9lCGwLkKyCUh2qeNkBj3875KE2
         33DWGML+R+jpHQbPBkGJENX+gtOypkpRXraGxRKevpmS3PaAvj1foY6NdKpnXsfWkMOs
         rQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753223790; x=1753828590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBB+90UYLZMUNkM8Iop40n+D0UzNuJmPLssHgoedKC8=;
        b=MoVHPMoz+c8B5AkR7wFGF5rh0kTPeoEhD9oDsu8pMP3DlA6Zkd5B4f+NzNOXdj2CAk
         pjrYbszma4W5dn8Yh+u+i69N3G38TayK0OWyEQb642kT08f0Bpff2F30+A6HfwnjAYmu
         bZIguVgBmDqOGIPz69Ytgk5E02WlsVBxhplFKDtc6JZD96/UFJuF6Gb0wsXxAxty06mN
         /o1TMpdgsi76fbKj6Mzc4MX3uagOJFbuVJdwmGMeL3ptrtB14P/1+Zo11vNDS2wyxkGe
         ZFZEAeT4eWpH08Kaxx6jKSW37flaP2fiLE9NXaBVTvxQnD7NR1htpgKNnlGgtN/6Hoer
         zLJA==
X-Forwarded-Encrypted: i=1; AJvYcCVBEKTX5WAteRg/YS5eRxo3RrsN16hywv0XEK9j1sax08XSlYmU93I5UNnvjF8P6odHkLTd/c1ux9XGBrqMjppURQ==@vger.kernel.org, AJvYcCVsnf3/PJ8saTNabWMVfr/dEh/w3bQJNYknZoZj4FPLHqEvJayTySoS0vvQu4inwXw/Xh9RTm8QLJFGdX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZQu6ozMkh5t/+S5Y8F+/EpPUrBuwutaVORDhRYHuEuYG+RIM
	hmnSLOd07A5ZImQNH4JRVuqeI1pIh2IybLoM+jSEyBZ8JXMG0v2L9hba
X-Gm-Gg: ASbGncuTqyfmekNWNWwyj9bt995z6gQ+7cOwvuuPM7ZFFCGXQzSmyD96tyU7Yu5HNAH
	ifJIZyfK12Wy4SaM2BR4jZRAySTpTgqVrZb1Nxdngz4f/Ys+F9y86eVUh4np+FtYcgayVtTgYBz
	nvEeJ7cRUDI3yy7GPLsDHhkQChKI0fW5sqVumJDQivI7b9PmZJmO+eTHSDXdZ0NLTjn6zsfe/qI
	PPchYus4Pd1wWu2cF3m3bqG+1Ad+zF5ZpjOxwkqyHD8ZKY+WUhteL6u/wQmLFScuSjRPHJyeB92
	GHlk/ojg5WuHpMwoYDokgy5ue/WhtSVFsucHDvrupbfFEWVrQrbuxlqJ6VYcisqj4u8aXaxS0TB
	kc0oUeavt/Rsl9MNDrgBU/KbooRt75Hk=
X-Google-Smtp-Source: AGHT+IEbe8BbhV+igVqGgr2sIN5xkSIsdDLD4nm09zpSxpKxfdqRu1gZLhD2/emij7TH9ZMxEHKGXQ==
X-Received: by 2002:a05:620a:6cc4:b0:7e3:417a:9609 with SMTP id af79cd13be357-7e62a03c142mr146618685a.0.1753223789697;
        Tue, 22 Jul 2025 15:36:29 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356b2a9a6sm595561685a.8.2025.07.22.15.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:36:29 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	vmolnaro@redhat.com,
	mpetlan@redhat.com,
	unixbhaskar@gmail.com,
	atrajeev@linux.vnet.ibm.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools:perf:tests:shell:common This file was missing the shebang line, so added it
Date: Wed, 23 Jul 2025 04:02:24 +0530
Message-ID: <20250722223350.414-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/perf/tests/shell/common/init.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index 26c7525651e0..9e9d4247ada3 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
 #	init.sh
--
2.49.1

