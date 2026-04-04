Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0655122D792;
	Sat,  4 Apr 2026 00:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261704; cv=none; b=SAC9FfAV2O/BH7Eri8Vm4e/PBojvFsq6A8FDKysZ3+UDT3vvBRqLoK3MUJBsbQwDCyXFNq4DAdEENmO/SCOM12+7lD3pRqEcDSBPjIX78RfJuGp/Zej+Q6HOJyupmGjWL2lDrxtP4NuL77RFOwdOz3q+vSn96JhqAo2KAOT8+6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261704; c=relaxed/simple;
	bh=racoVdlUknklLWdXqfx4On6wTpHp5LkCcD9mXuMqsxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DBxRsSH58zvmU8OGZGMJxv639JlI/NQLy8iQmmV3zgqOwOtt5oJ/0vP8MntfgTtYvPl3rHWkzOn8gubNdKnyStq15+yj1ukFGh9kq1qFt1VaLZjkD+8oNMSt8/ohIEAfPTuAUVuB5BH3ZcX5AhA38akff2hNsCWC216DGtPTNqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CT1Yho+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CT1Yho+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63647C2BCB1;
	Sat,  4 Apr 2026 00:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261703;
	bh=racoVdlUknklLWdXqfx4On6wTpHp5LkCcD9mXuMqsxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=CT1Yho+qwDnGP3HCQrfWynb2uZeMZgekoUhJlqZR4qk/X20DQ6MOJ4hih5pqf0M8s
	 fBFy/WJfJjHE4UWoH+oqfR+1iq5jjTg7KuTq3gdhL+HZrz1TQVYTEaE0vPAMCrrpb3
	 VeUcSmT0BaVjfbL9jL5tQFj3HzyeoJv88BI1rjvszJVwiPmUVyYN8IiOrH5GcfdxhH
	 YAPtKOESGDkSCMSpmAkMho4VfeoiTSi2t078cyLW6qtpmi7GMpRsPuBEaD9RLDWAdG
	 TA1vMU7sBkGtwztH2qVoRdIlzuutM9s3bRl+fc4b+zOysIRTWLTM9GXsz7+EbZX51K
	 GfI+zTI7UN6cw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Ian Rogers <irogers@google.com>
Cc: japo@linux.ibm.com, linux-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, tmricht@linux.ibm.com
In-Reply-To: <20260319010103.834106-1-irogers@google.com>
References: <CAP-5=fWmDYmyt5JGfVH77zjA6828Ocu7JP-B02=iifp+J_=9Tw@mail.gmail.com>
 <20260319010103.834106-1-irogers@google.com>
Subject: Re: [PATCH v1] perf metrics: Make common stalled metrics
 conditional on having the event
Message-Id: <177526170336.2123878.15559799803018296626.b4-ty@kernel.org>
Date: Fri, 03 Apr 2026 17:15:03 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Wed, 18 Mar 2026 18:01:03 -0700, Ian Rogers wrote:
> The metric code uses the event parsing code but it generally assumes
> all events are supported. Arnaldo reported AMD supporting
> stalled-cycles-frontend but not stalled-cycles-backend [1]. An issue
> with this is that before parsing happens the metric code tries to
> share events within groups to reduce the number of events and
> multiplexing. If the group has some supported and not supported
> events, the whole group will become broken. To avoid this situation
> add has_event tests to the metrics for stalled-cycles-frontend and
> stalled-cycles-backend. has_events is evaluated when parsing the
> metric and its result constant propagated (with if-elses) to reduce
> the number of events. This means when the metric code considers
> sharing the events, only supported events will be shared.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


