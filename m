Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC67B198E91;
	Wed,  2 Oct 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727906769; cv=none; b=ZkzGdI1m6ZmVPmV76blaKOuIl1+IDQxLcaWMq5MjYyx6ULDJc1QBcZMsvetPfdmCq+XDCWvRJ8qBR6ghgquNTV01WMnmOL0arlk0t/4I3uOfB6ZeqkhVnoixRE934RZmA6kATcl+wkp5UmpBKRxTrKx+TsbTweWlzIIqG9312ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727906769; c=relaxed/simple;
	bh=d5tRG+Gv0jnHThq3HwUyxiTuxndbrd5JJwCOxmr7xBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=US2ugrFFjn+67q9KbF9MPbUfgTcBNb13yUoNvt4poGlOO1YzCqb+4Ltfi1P5GZtkoD1t3cwlmcxUooK4Lzs6SAjuKnTksYkqsUtNraQKBMhiGYvAF72OjlPIeQSyzK71GxlpDlZCfPs19uMzSEgrkjLyGt/1j3B2lHzhdnj4QdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlNFF+TH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlNFF+TH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B226C4CEC2;
	Wed,  2 Oct 2024 22:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727906769;
	bh=d5tRG+Gv0jnHThq3HwUyxiTuxndbrd5JJwCOxmr7xBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XlNFF+THm1ysHtRhyi5dQYjDDO4tHVvYFtH4Y4ZwfAuHtmWGMiPUc1k04q4SUVFKW
	 VB+V+dDrdJ0TwB/GC7pc8sbOjefot2DRtMDHPGisWMihlgNQt5IuFL587K1mdeTGIF
	 3YzavDjlyQS5QSd+p4Z4ELZf5RL/MEbBQHjwqzKMcYJ+jXPhMZ+4T76u7hhxO/a5ak
	 3SOH+cUwBTYBpCLP6t998La3qYT4sNdeZ2wMQPLjV8RnnM8XFVsHym121k4J8hGy4F
	 UDMOTvpHlry29GxkmQyd6PulEy+b9AK8UwTZOuY4ww4JmC++nnIaFreFFpZz5fhjJO
	 1MjCoz8H0X5vg==
From: Namhyung Kim <namhyung@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	acme@kernel.org,
	Thomas Richter <tmricht@linux.ibm.com>
Cc: agordeev@linux.ibm.com,
	gor@linux.ibm.com,
	sumanthk@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH v2] perf/test: perf test 86 fails on s390
Date: Wed,  2 Oct 2024 15:06:07 -0700
Message-ID: <172790675948.3079764.14344518438206067809.b4-ty@kernel.org>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
In-Reply-To: <20241001124224.3370306-1-tmricht@linux.ibm.com>
References: <20241001124224.3370306-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 01 Oct 2024 14:42:23 +0200, Thomas Richter wrote:

> Command perf test 86 fails on s390:
>  # perf test -F 86
>  ping 868299 [007] 28248.013596: probe_libc:inet_pton_1: (3ff95948020)
>  3ff95948020 inet_pton+0x0 (inlined)
>  3ff9595e6e7 text_to_binary_address+0x1007 (inlined)
>  3ff9595e6e7 gaih_inet+0x1007 (inlined)
>  FAIL: expected backtrace entry \
> 	 "main\+0x[[:xdigit:]]+[[:space:]]\(.*/bin/ping.*\)$"
> 	 got "3ff9595e6e7 gaih_inet+0x1007 (inlined)"
>  86: probe libc's inet_pton & backtrace it with ping  : FAILED!
>  #
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
