Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF2420127A;
	Tue,  4 Mar 2025 12:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090544; cv=none; b=dJ8mqbPoJqZ9VDfRezvtGu3jebwdxHZXZ0eJeQHzRCodEqdlNqJ8+asl4oVUAiUtFnQM505SxsbWhr9JH0cG6B9KhSvF5ktJDpukG3i6ruAGMWNLm48grWs7LR9FPbvmPzW2JF3QAkb7esmQcxD/CBNem041oXwMxBlxd1omSuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090544; c=relaxed/simple;
	bh=RsFnLJWuyMfg9CLtT+X/6zuzRxgD/IvYYI0y6sHlLDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rL2nNqh3u/Etb3AR8myiVOfM1kHo0Y6Dx6g7SF0YO8O4rYEgl5eBcgzevQ4HlIZjN++zfcyE2FBZfiAjM6VxtxZ/8iG3Wj+aUEhFtJacSzmJHlXTrjbdRFkXzSbg0NjXnPuOIU11lTCLIgZJtFv1sd9TJM8S7gI09GpjqyxwIno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=uY5Ut9Uc; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="uY5Ut9Uc"
Received: from localhost ([193.175.198.193])
	(authenticated bits=0)
	by mx10.gouders.net (8.17.1.9/8.17.1.9) with ESMTPSA id 524CEcme030551
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 4 Mar 2025 13:14:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1741090479; bh=RsFnLJWuyMfg9CLtT+X/6zuzRxgD/IvYYI0y6sHlLDU=;
	h=From:To:Cc:Subject:Date;
	b=uY5Ut9Ucz/OfEyzHj2aHL6R/6W1tHJjBxHGJETjNRsJ/i/ED2HE7U3YIzgD7XCYlL
	 2yL4M6iw+Sfa1eQMkg95AOL1tg1ZMBxr88/bdug749L/aVcthvP+Xf5FqLHdXUBJkJ
	 ej1Z09K521nVypHlJktehFplfmPE6qzjvApbg6ow=
From: Dirk Gouders <dirk@gouders.net>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Dirk Gouders <dirk@gouders.net>
Subject: [PATCH 0/1] perf/Documentation: disable hyphenation for references in manpages
Date: Tue,  4 Mar 2025 13:12:03 +0100
Message-ID: <20250304121347.19861-1-dirk@gouders.net>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I noticed that references in the generated perf manpages get
hyphenated and terminal pagers that know about references and are able
to follow them, will fail at the hyphenated ones -- at least the one I
am experimenting with.

In case you consider this worth getting fixed, I tried to prepare a
possible fix whith explicitely turning hyphenation off by customizing
some docbook templates.  The BR macro could also be used for those
references but I'm not sure how widespread that macro is...

I'm pretty sure my proposed patch is to complicated or even false but
it should clarify the problem and I would be glad to learn how this is
fixed the correct way (or even why the global .nh doesn't take care
of that).

Dirk

Dirk Gouders (1):
  perf/Documentation: disable hyphenation for references in manpages

 tools/perf/Documentation/manpage-base.xsl | 44 +++++++++++++++++++++++
 1 file changed, 44 insertions(+)

-- 
2.45.3

