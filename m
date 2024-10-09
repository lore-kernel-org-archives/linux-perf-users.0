Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1215A1A0B06;
	Wed,  9 Oct 2024 17:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728496536; cv=none; b=RGDba2B5CkRrUgdc8mhtdx1kybjFsYOHea3JwSZ3P9642JXmgwJN7miqAyvel/MavT0YJQPTDXJIstyP0aXPpnFR1EmGifqaHa81/134+D7QTvh2rH8Ksbd1laZGVX3NcfP+ggnNem+aiFWoIhPt/m5uW+r2kQuTYllBa+OWGjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728496536; c=relaxed/simple;
	bh=WotZXmt4mPJz+W1gxqWxTRkhKu0xQma37zCB5/Zp5Qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=keqKngetrWWgjWIzAgddv+d+BDGRoQtav7W3WC2EOucfMlxvBWU67iK7Xs8TsMXwDj+aNCpZ1aEY3W8KihAqHVaaQiNMUNcsSlI22iB3coPg7iMEq1fC/twwvUau3pxq/PfppPQsgHIhEFCDM5u4DoHzGfKDem5LbqcJRaJ3WzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=horX0Sez; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="horX0Sez"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32565C4CEC3;
	Wed,  9 Oct 2024 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728496535;
	bh=WotZXmt4mPJz+W1gxqWxTRkhKu0xQma37zCB5/Zp5Qo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=horX0SezV/xiXHwsJvjY7MUCS2fL+6wiv6Pxb70guFKLxW0NRmONpO0ul2Gn+dnR4
	 hvSMFB8gIg64YGPOQYa0k2USsXripA9hBwSBRFnL28e4jfim0dmIQ3AJ8a6MPhCb0q
	 Lym7I4OM2J3qasXXCo1EkgI9+hyM1Czj8v/l09OQ+udcxah1IrzEEclwbLNkpS0pOQ
	 AqzWM/AcyEnuE4Zi5ueXhfUmjUBSehSNB3dJ2PNz9IssoeJ3mM0Z6RK2CR1djXnoWn
	 iAegK7hvc1NON4yCqsbmF58URZVSw7ZERkSgXod1l/8Ag3zm3+ylegsufW11DBptZS
	 lxMP46Kc4zjJQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	Thomas Falcon <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf test x86: Fix typo in intel-pt-test
Date: Wed,  9 Oct 2024 10:55:33 -0700
Message-ID: <172849651340.828572.15968412226288593249.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
In-Reply-To: <20241007194758.78659-1-thomas.falcon@intel.com>
References: <20241007194758.78659-1-thomas.falcon@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 07 Oct 2024 14:47:58 -0500, Thomas Falcon wrote:
> Change function name "is_hydrid" to "is_hybrid".
> 
> 

Applied to perf-tools-next, thanks!

[1/1] perf test x86: Fix typo in intel-pt-test
      commit: 9f759d41b3ed8feb550473027e674edf46ce7b94

Best regards,
Namhyung
