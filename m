Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F01803B
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Nov 2023 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W76exGFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966ACC433C7;
	Fri, 10 Nov 2023 13:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699623231;
	bh=zeW97rNRPUdz+KuoHgAUP4bAl5sLNJZUkAnGoySTVis=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W76exGFUQZVYHtt2nDGBJCNCpc4Bl8ZDBvZOidYVy1MW5SNiWLn1KsoCyEAF+4S6m
	 NxuRfwRf4lkdtMEsAvz7sJF/8JXSgvCMt2HxRpCwOmYuM0/F+YAz7tmHckSbsj+Jf4
	 gCgj6QxlI1m4vaV1lkzecaW0zUxdY7QoORGk4AVOF0OnoNmq/wnmfZxieDai6visH0
	 cfcWfW64eNMb72KNpSKG6JY7PvItjBnWQCXBdYbiTrlsftY5gortmJxjE9zpRpGnc7
	 A9qFezwplvd13muYNp+vTrxY9hRBH/R8thjrF8duvaptf++jvrlxMHCHAG98Hz8mvr
	 a8D+Xywi2K9lw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 6ACBF40094; Fri, 10 Nov 2023 10:33:46 -0300 (-03)
Date: Fri, 10 Nov 2023 10:33:46 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	sumanthk@linux.ibm.com, svens@linux.ibm.com, gor@linux.ibm.com,
	hca@linux.ibm.com
Subject: Re: [PATCH v3] perf report: Add s390 raw data interpretation for PAI
 counters
Message-ID: <ZU4xOmhlT5IQlI2O@kernel.org>
References: <20231110110908.2312308-1-tmricht@linux.ibm.com>
 <ZU4d0G23WOKwpIwb@kernel.org>
 <6d5a8310-d3e4-4fa7-8103-b50b100e22f7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6d5a8310-d3e4-4fa7-8103-b50b100e22f7@linux.ibm.com>
X-Url: http://acmel.wordpress.com

Em Fri, Nov 10, 2023 at 01:31:59PM +0100, Thomas Richter escreveu:
> On 11/10/23 13:10, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Nov 10, 2023 at 12:09:08PM +0100, Thomas Richter escreveu:
> >> commit 1bf54f32f525 ("s390/pai: Add support for cryptography counters")
> > Where is this commit?

> > ⬢[acme@toolbox perf-tools-next]$ git show 1bf54f32f525
> > fatal: ambiguous argument '1bf54f32f525': unknown revision or path not in the working tree.
> > Use '--' to separate paths from revisions, like this:
> > 'git <command> [<revision>...] -- [<file>...]'
> > ⬢[acme@toolbox perf-tools-next]$

> > Looking using the description I get:

> > 39d62336f5c126ad s390/pai: add support for cryptography counters

> > Is this the one?

> Yep, I apologise for the cut & paste error, this is the commit number in question.
> Should I reset a corrected version?

I can fix this up, thanks for confirming,

- Arnaldo
