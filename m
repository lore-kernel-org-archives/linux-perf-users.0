Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EDA196DA2;
	Thu,  6 Jun 2024 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693910; cv=none; b=jFF7BPu3GOrJW1M1DC44wu7e2XU5xHrR+CM6rTY5T/3pJmqISF0t/TF5Dru82/TMVliUlN55G5znljU8F8vdd/H74Tut9lHPg+J0qRdyNmQkfvSFQGyOG51nMdpE/e6Qv4wwICyADGoYU8yXrdr04t/YJcb1DrYOZCbXeaHDhDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693910; c=relaxed/simple;
	bh=O41E5mYK1HCbNo7OTdY8PzyG7mLhcJjX2LBf+/qZIEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sffEcrovt3KwkmlN/pfSHxRSW3zh7cx0DRt5/c6xRk27IhgcwxJBUDML0urYHz3K0OBdtW69+4WEzhRoo+nAVFIhB9klNRmJO4yMcrZSuPdBNBd0V7ns7/z4WzTN/ivINGQrDBwYaEeJIzmPhcSuBLsY7025bHTD5vWBB0RXN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9prq4Ei; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9prq4Ei"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B06CC2BD10;
	Thu,  6 Jun 2024 17:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717693909;
	bh=O41E5mYK1HCbNo7OTdY8PzyG7mLhcJjX2LBf+/qZIEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m9prq4EiC93Qtc7WfK4xLw5bUZsFqWhCOzxQGfujGItZY/vshvG8NcfEzkh0EDWUx
	 NvG+9HuAT9Twkea1GkUA4GuSWXDIgVgIxCYhjv+Ui2qixtp0A9feB1su6Xp+cHlQjA
	 tVCLYmGVrcu4Q6kveO0vmCw43IkyYRs7aRIAH8R+r0dp4o4w7EkmHLazhOxltm+6wz
	 QzDYLrnfa3uP3eSHI6fxpY2diJ1FA5JesWSwRwRvamw5hUcSq35LXa+DIT7Mf/Dbbw
	 +Zv0928HvVDW7EnM2W2iSHhzqGRCFC25lvCQdLXN5IPWeiqQDqXcIk/Qo+HnQ6idTc
	 TaW76Q0ZulgEA==
From: Namhyung Kim <namhyung@kernel.org>
To: yangyicong@hisilicon.com,
	jonathan.cameron@huawei.com,
	peterz@infradead.org,
	mingo@redhat.com,
	jolsa@kernel.org,
	irogers@google.com,
	linux@treblig.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf hisi-ptt: remove unused struct 'hisi_ptt_queue'
Date: Thu,  6 Jun 2024 10:11:42 -0700
Message-ID: <171769384225.2339517.15362661960178701693.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240602000709.213116-1-linux@treblig.org>
References: <20240602000709.213116-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sun, 02 Jun 2024 01:07:09 +0100, linux@treblig.org wrote:

Applied to perf-tools-next, thanks!

Best regards,
Namhyung
