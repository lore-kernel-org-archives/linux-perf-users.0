Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6A03FBA5;
	Mon,  7 Oct 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728278061; cv=none; b=TZmliru0MREFU9/H+5v7lgcR4lrqJGIhaXC59AlTB+kwpdfbpyS2Dlzc3pceRkQv0ENMWbZLOEuxMppfJWIO42bGq3/OVaJVW3WqYmE0+CsqKbvdrAZf7sHgYwJdq8AlqDZkyJtimKymzqSz3MJc4akzawNQDe3GU0TN4ldV4pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728278061; c=relaxed/simple;
	bh=renlO5Q+KU0zKLtp+OE0UgjCY/5gvz5IK+uND59j/Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lLDJNgMSOvqK2lFBdVWH5mkIjV7JfjBMIylj9POHjWFZMF66AWNPnB7GBfoSiZ3eHGGj5SONsPbuQpkjQWA8jNHNjRc2ZUrx331TOOnmWjuHfYQzmR/c3CSIOUfl2gFU53Tn2tLdztgQu0BPF1VpLfZXQtEQDwUMHircLE6tDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7w4Hum1; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7w4Hum1"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e050190ddso296575b3a.0;
        Sun, 06 Oct 2024 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728278059; x=1728882859; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYWUUavFVintDMu/K892SJdqx3k+JQOhDyBS66qFRxg=;
        b=l7w4Hum1s1gXV8XAd2u30gDTErFQ0XEUQdqd3eZM3FLYGBOmViLWCoKeNNs+Q+Murc
         VgumW7PIzeyf+OhZ004xD0lk1Y2LSSdvZD1Z7Yl8JVu9k/kSZ23aG1oAPo1WyIHLaf3/
         G0xFiMzwMU7hEKNYeytx48aQdpXdCDc5xyf7kFglQtPOyz4UgPpGBNVIOojhgY1HidbD
         6cpCglNoJp5i8/w42Z+Y/CsoXn0Se9gkmmuIF2VOgDR4k46H4vTgPI8kH61k82oiXT6T
         lEYbf65SMnlr+2F20MGc5cQHyVQKcZAJEeB2cID0ZZo0kXLomVujwdWtQ1rtnNNCuuSt
         ak2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728278059; x=1728882859;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYWUUavFVintDMu/K892SJdqx3k+JQOhDyBS66qFRxg=;
        b=qN8J3Ds0oHBA3IdxTJuYfpOFAvIY26e81BXYriJtWeERH568D0d1TOBa+Fnib+0kv2
         rB8q85GFGiW31wiXqMb83absQyd8PA+t63AyMfkxY5m+h5YxyLuaRNotyp+zH+MDePYF
         Qia0vMPlmKNDGwvDkhGiGRzyVGXfv7j3//SB0L1LO+oaWkegUhVJpArgl1Gct9d0Zlma
         QAvIbJNGtt1Fqy5cHGbcdRr91COScK43FbSyGXOAsJ/I/A3t+Kq1TO3GiHWeS3vcoqN5
         iOpeMCxPg0+i0O4IvVqwPOXdpUGEGij1x2wscjist6I2kYl3NyRn6RHfwoK+7s+/hvcd
         qT2w==
X-Forwarded-Encrypted: i=1; AJvYcCX13Qfv9G2eh1kwjnWYlW9yJkvMH7sXAhGifIaSP3qnpQRCLjKTjIoGMqukmNt6o40nIxN174TdMUrjeHPU7cyHrQ==@vger.kernel.org, AJvYcCXCt6V4WgN9dxUoXg1YngXxOnjrxSL52yCCMwdKIOvjPkwv37MJkFfeUObrsnAvMu8b79SAAE+iispqCUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0zX7nW0dN/gFqINsTL1S+tRqQz3gJGXl6yg8cmf9iue2JWrKI
	9jT/9N0j+ndXskXczDexbHqjx0FgcAjYOiMkVkG0BOM0l4doERtj
X-Google-Smtp-Source: AGHT+IFS1T7IyacUZgNgtQ9tvKdNoBBgx6N7t7Mg+ercpCn19WJ4V83yGoPhodjDTSO3nhv40BU9Ww==
X-Received: by 2002:a05:6a20:b598:b0:1d6:de67:91c0 with SMTP id adf61e73a8af0-1d6dfa46dd9mr17933152637.27.1728278058949;
        Sun, 06 Oct 2024 22:14:18 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0ccd04csm3560706b3a.46.2024.10.06.22.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 22:14:18 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH 0/2] perf trace: Fix support for the new BPF feature in clang 12
Date: Sun,  6 Oct 2024 22:14:12 -0700
Message-ID: <20241007051414.2995674-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new augmentation feature in perf trace, along with the protocol
change (from payload to payload->value), breaks the clang 12 build.

perf trace actually builds for any clang version newer than clang 16.
However, as pointed out by Namhyung Kim <namhyung@kernel.org> and Ian
Rogers <irogers@google.com>, clang 16, which was released in 2023, is
still too new for most users. Additionally, as James Clark
<james.clark@linaro.org> noted, some commonly used distributions do not
yet support clang 16. Therefore, breaking BPF features between clang 12
and clang 15 is not a good approach.

This patch series rewrites the BPF program in a way that allows it to
pass the BPF verifier, even when the BPF bytecode is generated by older
versions of clang.

However, I have only tested it till clang 14, as older versions are not
supported by my distribution.

Howard Chu (2):
  perf build: Change the clang check back to 12.0.1
  perf trace: Rewrite BPF code to pass the verifier

 tools/perf/Makefile.config                    |   4 +-
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 117 ++++++++++--------
 2 files changed, 65 insertions(+), 56 deletions(-)

-- 
2.43.0

