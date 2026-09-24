Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1840B38C;
	Thu, 24 Sep 2026 17:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790272115; cv=none; b=WdYVAxjpott1ViudOxsylSesN+cqFk2DILHad7rce7MgajSN4xm6jhcOXIQNFgqBakLDCjqhX9WOvrdSxLswaQ8SDk+gK0dlaOyXuMVPZBhfcB035OLM4udFGKNzqQRTHJ4DMXA8wkiQjCvD7oTcGmirW6+72vhluIKTyCU/Yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790272115; c=relaxed/simple;
	bh=3/lyKLPDSE2eQxgDC9pSfTOBUZsoGj3+L7XyB5koOCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8XjxKOMd7/EVnDbAixPnszijY4LL+mnseNrQVuOz+UATEO7eydSKzDc7YprcBCIsXedBQFz+fffXlSe3CcbeSgrlQy8xlQ+KKrCTO4ZTh67c5ZJfgpMKwXAZJSBFamK2cxL8VOL2jnZIfqwcSezeXPWls283Ot/lGEr5ZzPXFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpvKI9Pj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpvKI9Pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E981F000FF;
	Thu, 24 Sep 2026 17:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790272114;
	bh=33TD4iM28M3pUJ7zrgxZXuOmHs6RVQ1v9+gjv7l0qZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bpvKI9PjTJSuDkk2uyOJG4DfCpSHKTZaasRjt1Y49V7A6VPZ4OQ9ENHFeQ90nl/N2
	 iv2cUGVZHk3pbKYTLaocr0RxJaeLylz7qDpRgoX/D/lb5cddX8tTTyiaNp0FyG19WN
	 Emb3c7EwpAV0chWQ2+QtYCg2CxJRdBkuGsMBpF1j59hGXZPD7JB9RHAMFxQBty8qXY
	 Xykfpr0DzLNzuLcnxCR48KW7Rizl8usTZVvf4WZpJ4JTTZU4gNTuVRriT5/qJi6Gm1
	 9mGd1ycywFnY9aGHTzL5Fss9g/3qt3VUXua6YXmhHJtwIc3keepj1O4aPMPW+L4OLg
	 Rz4DjJucFqBaA==
Date: Thu, 24 Sep 2026 19:48:30 +0200
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Subject: Re: [PATCH] perf jevents: Rename OMR offcore_rsp attribute to
 offmodule_rsp
Message-ID: <arVibiOued95_li4@x2>
References: <20260923015517.2665398-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fXaB9vvDGkT05kKtHfY3K-2sa5BzpZbKK5htVVtXBeTqQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXaB9vvDGkT05kKtHfY3K-2sa5BzpZbKK5htVVtXBeTqQ@mail.gmail.com>

On Tue, Sep 22, 2026 at 10:21:58PM -0700, Ian Rogers wrote:
> On Tue, Sep 22, 2026 at 7:02 PM Dapeng Mi <dapeng1.mi@linux.intel.com> wrote:
> >
> > The kernel renamed the OMR data attribute from offcore_rsp to
> > offmodule_rsp to avoid confusion and keep the naming consistent.
> >
> > So update the perf jevents msrmap accordingly.
> >
> > Link: https://lore.kernel.org/all/20260917015234.981153-12-dapeng1.mi@linux.intel.com/
> > Link: https://lore.kernel.org/all/20260917015234.981153-13-dapeng1.mi@linux.intel.com/
> > Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next, for v7.4.

- Arnaldo
