Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE0F21A931;
	Mon,  9 Jun 2025 19:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749497516; cv=none; b=PQEcPkGEhtAHv5fd9iQyMUaf+//wnZEPBT2TwFVdS0EJIt/b4OZAX+7TwbG9RpvE4/7DcLIR3yaUpiyZAT50wZdC04rQ3wGOGfyi6k7Qcb8zQVnBiSpaeqvHX9jupGLY6BodrvPbAJDT0UH+sZG9fqChxXlglKhAiG/e3lsntpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749497516; c=relaxed/simple;
	bh=4Y8bkcAq5McLJfNA/dpEXN9x+C35nA7W0LC1z+syPSk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=nbAezDbuV5Pqw7dJEoMFyWxtSGuQsfllMElDoDefzLj5fLfYnXKtV13UpdqqCL5jn/M/ltvle1SWfMSE5J/DnIqvhoTPdTTVSjb6uEaUwqGiNSPgteEgd+gjmc/LyiVkp30SvKIb2vy5yB3Irk4TCAcA/HcVyiXkFqJMcMcrwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 40A8C140DE8;
	Mon,  9 Jun 2025 19:31:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8FFCB20026;
	Mon,  9 Jun 2025 19:31:41 +0000 (UTC)
Date: Mon, 09 Jun 2025 15:31:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Matthew Wilcox <willy@infradead.org>, Shivank Garg <shivankg@amd.com>
CC: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com,
 adrian.hunter@intel.com, kan.liang@linux.intel.com, david@redhat.com,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-mm@kvack.org
Subject: =?US-ASCII?Q?Re=3A_=5BRFC=5D_mm=3A_use_folio=5Fexpected=5Fref=5F?=
 =?US-ASCII?Q?count=28=29_helper_for_reference_counting?=
User-Agent: K-9 Mail for Android
In-Reply-To: <aEc0MNj9JNXbLHmw@casper.infradead.org>
References: <20250609170806.447302-2-shivankg@amd.com> <aEc0MNj9JNXbLHmw@casper.infradead.org>
Message-ID: <E40B36E2-1D0E-4769-B155-0175A06DE3AB@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8FFCB20026
X-Stat-Signature: k9yoy8kk4pct4cgbm3pm7m16jbrdwpgr
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HlEqgydZliZ8V0YNuMnhWSh7O6b/U0aA=
X-HE-Tag: 1749497501-489981
X-HE-Meta: U2FsdGVkX1/wC+xwbUOOM6hNfAHr04ILxemjqYQqRFOaP9s3RuV+XeQnii1TH9EoSlsiV0eE2XaJWkXaCx04RgCHotQSITVJmr8E2Tvn22KyKM+TkcDvfswfx6T4mqxJ8DidG61rKzGIK9mX+f2cdvL3F/VP1ZgohuJOa+v4TnOigXaWYy6qC/A7aagwVcBpABZfr/Hca8GFu/r9NMkuVNANzreAeV40rL/A60osAim8y9w1LeIB0T4w+qp4ECBGwr65EakSsMVojpFBiaNXy08N9vYv+/bPWbn7kn3BvRqDOcskCb6hKQ6NA+qSROImAEI2RG6zI2P/yo/ANJBPiBLIkhGbs7OVW4JRPrAF0DAQQsuIjCuQeBnBIUY37/zdYXGWGHTkGDM+wSfduXXBY7klRD4PzWh5z/7oAKkTc6o=



On June 9, 2025 3:21:20 PM EDT, Matthew Wilcox <willy@infradead=2Eorg> wro=
te:
>On Mon, Jun 09, 2025 at 05:08:07PM +0000, Shivank Garg wrote:
>> Replace open-coded folio reference count calculations with the
>> folio_expected_ref_count() helper to improve code maintainability
>> and reduce duplication=2E
>
>If it needs this much additional commentary, perhaps it's not actually
>clearer?

I don't know=2E I tend to over explain as I rather make it totally obvious=
 what is happening=2E I wouldn't say excessive commentary is necessarily a =
sign that it's not clearer=2E

Not knowing the code, the explanation makes sense to me=2E

-- Steve=20

