Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD7921770B;
	Sat,  4 Jul 2026 16:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783184137; cv=none; b=HRmCR7OaDhqsauBqDgNPkMs/05IxXlLMCSLpzmfR/za5ZKe2MSVqdYSQ4GL++rdvgeIfXZ24lVhQzz56MNqyV4mmRccv5LbnJ8Vbj9NgHYVFj+YgZh52giraH8bib33vGJ82iCQK9xSdYn2tLj5JE2QAJU8BaT6b5b4XE7X2diQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783184137; c=relaxed/simple;
	bh=WAmug9nWXrXQj+oVk7a/urXM4MQaAO181SIPRJw8i9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STs7n1kRwb0hQGPD6s9hkTB4WBi4xxcWTIuEtZ+0sgnFR7LMv1JsWPpOoGcORLT+cvteyquwVjRhAWNjpS9U+123XtIg4uh+qvB6P5pxgNE6NWtNyN1Ae18BhnPf9z4kLsSYtuIisbM/4sv8DD22EGarn+v6krugi1ikh/JkLjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZM2QSgQs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZM2QSgQs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E1151F000E9;
	Sat,  4 Jul 2026 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783184136;
	bh=8aQ/K2DgyvYdahzUIuLNcQqVZGdvyj+f7LRsp81s4DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZM2QSgQs8gs7DF0VNQtUByUwEIbXAd1yPxqxDUmSxNSd6j0dxDIMKx3988Wt08+WE
	 rZgP3mGzDtsGRQCs7qkN6DShCbliS2Iz7Z144IY6SfzEenMOTP24grJW7rl4LXGHJU
	 h4kCio81/DHa2Bb6rF8EKYLqLK+YsYXxizCMGJuAruTJGcdG/HoNrePZgXuxImNDIO
	 V/ZFGYa/+gt3ShupNZHCes3t6UpWqPO9vh9KvvdRGehk4oITunTRgQyS6GpWTxWbS2
	 3s1Hi/Gnb5XaXo1YkIldPfIrFJV+Qdu3wAVkYlKuhuAibEVfbA3BlsQj8uoOeanCU3
	 Y8SoBG1Bcj2qQ==
Date: Sat, 4 Jul 2026 09:55:34 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: acme@kernel.org, adrian.hunter@intel.com, alice.mei.rogers@gmail.com,
	dapeng1.mi@linux.intel.com, james.clark@linaro.org,
	leo.yan@linux.dev, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, mingo@redhat.com,
	peterz@infradead.org, tmricht@linux.ibm.com
Subject: Re: [PATCH v2 03/16] perf top: Fix sb_evlist leak
Message-ID: <akk7Bp93q4Vjg5JM@google.com>
References: <20260623053515.2677888-1-irogers@google.com>
 <20260624051535.3584977-1-irogers@google.com>
 <20260624051535.3584977-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260624051535.3584977-5-irogers@google.com>

On Tue, Jun 23, 2026 at 10:15:21PM -0700, Ian Rogers wrote:
> Fix a memory leak in cmd_top() where top.sb_evlist was not freed if
> evlist__add_bpf_sb_event() fails. Note that evlist__start_sb_thread() and
> evlist__stop_sb_thread() take ownership of the evlist and free it, so
> we must only free it if we fail before starting the thread.
> 
> Assisted-by: Antigravity:gemini-3.1-pro
> Fixes: b38d85ef49cf ("perf bpf: Decouple creating the evlist from adding the SB event")
> Signed-off-by: Ian Rogers <irogers@google.com>

Looks like a leftover from v1.  There are two 03/16 patches. :)

Thanks,
Namhyung
