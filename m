Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7146C359A75
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524964; cv=none; b=PNXxky4wKVPyCNn5t6x2lVNME80Uxcj4TlAsKkinKLs655xyPhn8UU8CTvbHXdTkq+T7x6ArITa2239rH/zLx30ZxwTIIUZvvDX5JebNqLUSLWDGT4gwu20S4hZtRjYHZx5X5FAtVlKzjL3oYrDi0VrSpMIPazuf2HR1lUfxqvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524964; c=relaxed/simple;
	bh=IOWFu7+gwZKZDwVQNqnCY5rw+EriqrInnXNr/HJjuuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=muFsp9txiqaanyE8Zoq3Ahzm0Eht5n46+1N9QC+P4lagGZHhWafJCFrj3L5FKdCH2BEZrC4c44JaRIF7e+F1JPn9WsESCREwowcY01iD2tbNw96o7F0wsLby9paRg2V4p9hZsbrms9fcQ3NBxGAPXt7OfBQQZvQu5aHteDuVg28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fYNfQJJv; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fYNfQJJv"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso36645875e9.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 00:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772524962; x=1773129762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IOWFu7+gwZKZDwVQNqnCY5rw+EriqrInnXNr/HJjuuc=;
        b=fYNfQJJv2TKtsOL8uOEi/CxDsIcaW/Wx+VgPL9rlbPoU+ok9uCFsBuH88fXhyPgOHb
         nUqMFH6lb2Tq/mqSU1CE+xMNCtZ+Ad99Fqhbcw9JihciMRA8efbaKwiXasSWKCIHuLT9
         ryTTK2sk1lZQmS1isnTuUdxWtjMfKjjFus7TnFg5BUYafJBF5nlA0ZU+/mqrdgQEwj0i
         /eR52Q+4cy0oCOjSGucInimvtALTId4bgDIJyAKvwN4DztBDYiM+krbCQLLWf/XiliJs
         BWLXbldWui32nVhk9EtUKoExhqs+3looZgc/66fKZBLWmhbfU863VqUx2UkD7hintqkd
         GsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772524962; x=1773129762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IOWFu7+gwZKZDwVQNqnCY5rw+EriqrInnXNr/HJjuuc=;
        b=HSZCp0bvOmcOPn477WRi5pOzSMgVQrNZH7FQVB/LyPUZ56w5y/eKIqPsSMFMbE3VN3
         lQcnWKAViyu7Vb86b416fVAzKT8tnnseWDPrMeYgmszRi4mFgptfzC8afgeJm1vZlMFM
         tQVTS1WFCK45PFlfbYdegsT9eZws5uyXWXBocVLpWxCO+JyzJPZrzk5isv2qc6Rv7vdL
         TpJ4d0r4TbyUisixOznMTQuS0XoQLT2GX2bUV9qkWSqB4pSzSK10TVEZ/Qz8VKmGejjK
         Okcmc7bP+k40ChBHd/bvtqyUgMiZs7Y8baw8zdf1gQl33esHbGCgrS36GIP8DrFfcgOt
         utsA==
X-Forwarded-Encrypted: i=1; AJvYcCWdJ8GrazZNJo85BOFJ1Je4HUBhqvybXaMjJF84Qq4jodw9fhB864Gk+FJjXQXIqkwS3EHEm3OnqJ/+oIOMDpeK@vger.kernel.org
X-Gm-Message-State: AOJu0YwQIONN3nDeEUsSnLY2yPQiBei1IS0d7j2wgxfClDZ2Va/nseWD
	KyndpaUaK3DzU60ldijMuLZg1+iEOCRxYkFWvCelKHDZfpNdgzr2wQju
X-Gm-Gg: ATEYQzw5zS3F6bZ2rFJeuWo6yll/2lQfR3SnsUYOHtmyhRoYL7s2vUCHinaxmS8/iza
	M1Jb56PeCQMYZgINxjEwScKAGFZAh4m/BRsgdqwfDLXH+jwX91w4iRzkcrhkFT4+y4gu2JQd46Z
	z3wyyrgz/wBWMskeIFefKoYNyP4eDuce2NuQQnLQB75x+vSYUK+fq36KOXxoVntmVema8gZ+oi9
	LaGNZlw0jLtW0eevVPzXTkSZg8wjyP6h6umXmbShYhd8vGCyLfHVuntNuHGCpwyJV06NeKE0aA2
	4V49FzoeGr4wMDkdfxXgt26ASSntyO5Lg62vZMq4I4IzibCZ8pKwKHfKyyEF+DzKdD+PlQ97mFa
	pcyy0vkuuXL1YK0oOtrA6TcvXDEdUAdduw5N+DA6204MIw/JHyyWUy2vHIzVGO/ABAuTCSR/ugN
	8oTB+lgA1ykNRyEWMMWbx8AClfe1VkhU7Ua0s3QdUPY1cbhtUlqg==
X-Received: by 2002:a7b:cb96:0:b0:483:78e7:ce15 with SMTP id 5b1f17b1804b1-48513e9cb2dmr13499495e9.13.1772524961413;
        Tue, 03 Mar 2026 00:02:41 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b485a0b6sm17371762f8f.39.2026.03.03.00.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 00:02:40 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: wangqing7171@gmail.com,
	acme@kernel.org,
	adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	mark.rutland@arm.com,
	mingo@redhat.com,
	namhyung@kernel.org,
	peterz@infradead.org,
	yeoreum.yun@arm.com
Cc: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf/core: Drop an unused parameter 'ctx'
Date: Tue,  3 Mar 2026 16:02:30 +0800
Message-Id: <20260303080230.4023270-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260107064351.3682174-1-wangqing7171@gmail.com>
References: <20260107064351.3682174-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
Ping again, thanks.

--
Qing
