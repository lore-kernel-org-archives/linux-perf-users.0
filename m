Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559D2262FD0;
	Tue, 30 Jun 2026 23:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782862555; cv=none; b=cSz4t4Opx5IrnkbFVmRGTpM2Tf1RNxvKKwWIOEv0L3XZry6I5/BRgd8sqO3v/vDwhgzrqgcHz/4qN7JagBdcAGl0ubfqqedlyL11UDxuiY09+65jQ8N8ImbG9mEuBL9BRYOKMrwrT+KFP6fM484YFm1EXXc7NGQwrSqL9tS2jj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782862555; c=relaxed/simple;
	bh=rE0Mi/0y7I5+8QE4W1UYbEUkvRbhJKv65Dh84OlXriA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nakTbdlEzft015HplPaHOZX/B4ZIf3lGATda1oSeVFwd2CxS/A0CZk9YzQZd85jy2cO7tIvg+d0GaMipI9IqHGdSxHoEzrIuJB+fIBQAS749KhvDsmZLvCETvGhn9VC2frfK6n+iW4fUmbGgiwpvdxMKz80PJy02qLljzGdRzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHeE4Nt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHeE4Nt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D01571F00A3D;
	Tue, 30 Jun 2026 23:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782862554;
	bh=CDxLsxVfkbLQRPgtf4a2DPhGbS7uctNKj95MDtbkTX0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=YHeE4Nt4OYOz2we9Rp9rScfov5rGKj3gUpPEQFQ8IPMUjRv7Ci6rx8zn734AAIN+r
	 yOPDSFZrif2MwowNRiJ1xB+vcjdRqZrxsM1s26sxRv2d+8IKqsVhBjnjziINO57VvS
	 CPuJNT+8vmSL3ru7a/7L3UqTpXAfodL6EG47/lMZuW35zNZ/8UKIHNr6gIuqphMO0s
	 wgWU5/5lmlS+l25UuTkTQR6V2CQSRyA/bPybolc7NI6q3JKK+ftnYZcOTLw9zaK6EF
	 w3fGM/0zc09wzSI2Nl0wFYIJ7+B1ryfN+TkKReZFWJQ4wkgmqYEIJX3OR0UARvCZ40
	 HRGYXgV8uPdcQ==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Chun-Tse Shao <ctshao@google.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
 afaerber@suse.de, mani@kernel.org, dapeng1.mi@linux.intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-actions@lists.infradead.org
In-Reply-To: <20260609215046.2391903-1-ctshao@google.com>
References: <20260609215046.2391903-1-ctshao@google.com>
Subject: Re: [PATCH v1 0/6] perf vendor events intel: update
Message-Id: <178286255381.2863034.8189687610180090122.b4-ty@kernel.org>
Date: Tue, 30 Jun 2026 16:35:53 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 09 Jun 2026 14:50:39 -0700, Chun-Tse Shao wrote:
> Sync with the latest perfmon events from:
> https://github.com/intel/perfmon
> by running the script:
> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.py
> and copying the resulting json and mapfile.csv changes into the perf
> tree.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


