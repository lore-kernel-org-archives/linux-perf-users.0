Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624997;
	b=O8tF8WbS/JFl+nRMReW2ojX+Se+4dQPtfn8xImNi9h54cEFYDyxAOW/mZDDtfz9OxjGv
	 /N/ENduDCH6LQci9wN4PhM1ScTNHv1UzayapLqoQN7ZXjqjQbfCI1MHB9+K27TFNQedDV
	 1BA0uY83Y1d0pY8u36qgOJGBNGFFJ62eHbphLNkXk+Dg3Q3IdjPfzb6q3kfRazgg9E1Nh
	 B1e/FF4K2QyTFc0S3/etpMzKC1K+azkYsxus0tXRciTU+8K9lvn5mt4q3FwGdCKhb0AEG
	 PDjw94r7MYoEY5DLRiRjZQhPnQV91g5cmXRTREZOhPpRI6nUKUmgc7fgrmgojzVJFHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624997;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=Ee+QhL+jGzYROOC8qFpQ6JHBwy94Pn04iWWAKqmrbzs=;
	b=JYk5BFllKd0+HUTmnEQPzlb5swEHCj5yzm7OuATQiCf+6TnrABK7ETxmEzjn4v1yxIZG
	 eqXMqxYCp5XtHH6ikgj9dImfbfAiOK8Sc2juDGhCvOv1cuydoFz2np/VMFQ6PrvSPSb4H
	 LdniwSztfQWGXZkPxyfD0gIOrUnN6zwSa8114lFcfqaS3ie67s/poOll9lYU/GLctYKJn
	 w82nOiHhkT4vlnQW0umk2Ch5XRp0XUsUJyt2ONA+N2VlziPNoIyykyZ3edj5bbQvvWqk6
	 RivTGXPxdwGPq2ih+5V84ejFaHm87L/XG0OJGB0T6MoN2E0N6VByersk3l+Wid/qirw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJHwZO6r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A23C606A887;
	Sat, 14 Nov 2026 02:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gJHwZO6r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C991F000C6;
	Sat, 14 Nov 2026 02:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794624997;
	bh=Ee+QhL+jGzYROOC8qFpQ6JHBwy94Pn04iWWAKqmrbzs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gJHwZO6rQw3dqXeu+x8AqI7ogzmRzZ2t2GP1pvdyxBL2mkHZIdyoylkzzmi7HeKE4
	 At13Tw9AwZGVDOowZOV6VGsVB+h/02onip8cY5b0iEVZmsah5pWhMwDLsSfizJx+D9
	 5/lGvjKnmkE6tz3S1sbjZoPhrn4Zm8WO7AAUYnl35m3LsONFXsgXkwkWesnT/XOvy1
	 O5nj2A1SlfsAzyUhjGaFYS+ofgMbV+nI1UhvvCiQWDkguVVYE43Nd/IErtjUdp8pg4
	 q7jT34LhMVWdZKSqR0JYrRw8u6ypJTAoMdoGIsffELE024x8bjLyE7pImOnt4PL+hl
	 UendzItPOp6ng==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Zide Chen <zide.chen@intel.com>, Falcon Thomas <thomas.falcon@intel.com>, 
 Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
In-Reply-To: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
References: <20261109004402.1403713-1-dapeng1.mi@linux.intel.com>
Subject: Re: [Patch v2 0/5] perf: fix test error and improve c2c
 memory-region display
Message-Id: <179462499604.532197.13539338398723693924.b4-ty@b4>
Date: Fri, 13 Nov 2026 18:56:36 -0800
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2

On Mon, 09 Nov 2026 08:43:57 +0800, Dapeng Mi wrote:
> This patch series fixes a failing object-code reading test and improves
> the c2c memory-region display in perf tools. In particular, it adds
> memory-region information to the per-cacheline view and ensures that all
> sampled memory regions are displayed, rather than only the last one.
> These changes improve correctness and make the c2c output more
> informative for debugging and analysis.
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards
Namhyung


