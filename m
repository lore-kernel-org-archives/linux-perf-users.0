Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660D8212B3A;
	Thu, 13 Feb 2025 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739467292; cv=none; b=kWcNbJSQ0p1LGtZQJFGz7oCUNV8LhGICA4n/xxW/GGBR0D1gbcP7K8LqK85M0MF5GY0nRWpFkP+pPWp8IzZbaIY7dlOgI794zyZfM89AXT5xsSdsbvec868CrOU91YGO+JO84CU7b3T3uMZ4DJRCXTYNCQdiO1f8ULuo11oINEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739467292; c=relaxed/simple;
	bh=4ses7YoekYD4cSlsyNJMow8WB/607I6tIIO0ZNGO9Cs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Xm+birBfEXPVjA2cBNPviXvBCP66XWIyLSw2+z9XUPABU+v0YzS7W5Ln9wpk4/FK+GAj5ZBjxaEklEgVQXIKYHINxoB+aYhYH6VpJV+q9M4EAzACb18pVMboBikKI7b9HkEcnWQw1Jp+Brc6h4QOWkddVXvd/v30e+aXoI0gAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lwgQfrMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lwgQfrMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5941DC4CEE5;
	Thu, 13 Feb 2025 17:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739467291;
	bh=4ses7YoekYD4cSlsyNJMow8WB/607I6tIIO0ZNGO9Cs=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=lwgQfrMbETt8yPZM9t6DrGPdrV7+W91P/hFCuZt9GgLXJe6tIQQZJUUO/vvLSgQkh
	 FltAPHl7V11oiPTmAot3vn0SdcIMJtdt3w7U6dLieXn1q5XSAmr8ejSCWukS2pkf3q
	 vDmKP7BQHYx4azGK9G+9bwk46qc0coCBOwf6Z0j8s1iD0c0IrOWyEhwc4Te8yk1dRM
	 7SROavUOtVeZQPZy4MiRjfC88NtGuLKEGM3AqU0hAUtyo7Z5C+g8lKrsYXMQ2kNy71
	 HLbbKg/KnBA+Bc8HS9pf4QspnqW+dWxy79i396PqptPkw1sQeyehxeYNvKKdt+5MQ7
	 ul43Ig77BspAA==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
 Kan Liang <kan.liang@linux.intel.com>, 
 =?utf-8?q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Weilin Wang <weilin.wang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
 Samantha Alt <samantha.alt@intel.com>, 
 Caleb Biggers <caleb.biggers@intel.com>, 
 Edward Baker <edward.baker@intel.com>, Michael Petlan <mpetlan@redhat.com>, 
 Thomas Falcon <thomas.falcon@intel.com>, Ian Rogers <irogers@google.com>
In-Reply-To: <20250211213031.114209-1-irogers@google.com>
References: <20250211213031.114209-1-irogers@google.com>
Subject: Re: [PATCH v8 00/24] Intel vendor events and TMA 5.02 metrics
Message-Id: <173946729132.1291083.17098907860131153081.b4-ty@kernel.org>
Date: Thu, 13 Feb 2025 09:21:31 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 11 Feb 2025 13:30:07 -0800, Ian Rogers wrote:
> Update the Intel vendor events to the latest.
> Update the metrics to TMA 5.02.
> Add Arrowlake and Clearwaterforest support.
> Add metrics for LNL and GNR.
> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> 
> The perf json was generated using the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> with the generated json being in:
> https://github.com/intel/perfmon/tree/main/scripts/perf
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


