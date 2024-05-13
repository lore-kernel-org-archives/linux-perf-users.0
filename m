Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF93A1A2;
	Mon, 13 May 2024 20:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715633109; cv=none; b=pkOjSuCn+rHBi3ypo8w82QMh0jdGI987XjKDqIWBcvL4GAFs0oPOHsbFlE9O4JtnistcqvCT79z0zj8Cb3yVszR9knzR08axFFKUI1ZNHtQQRXjzlmPZV/ZXG7SRqutBGepxQMFl3bphLvGH6PFJAa/V1+rP4oCvfDmYkK1BI+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715633109; c=relaxed/simple;
	bh=aF/Pllhk6I653hcEia2iO8Yd+UqBm6WptITdg6zZZkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=at9uQW4Q1UsyvtSpGPKRR2+obfuv0BkUMup4+VdHoKsONsGkvfjryz00ojxntq1DiuVyz2MCavkdi38SPnYA6rg7kCT21enW67U2K1DdECdWvOYUbe3q0RYCSmTX+lKqLvX+5CBZg0lqYY3GShbMYh+yNq0zJnU+EgVu0jkzZqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-61be599ab77so2161971a12.1;
        Mon, 13 May 2024 13:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715633107; x=1716237907;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZN5aHmJD+8Qc+VF/qva9+v6a6gaT9BFTUwi3zjLZGzs=;
        b=xIl6IjR7vtRDuVjSJbzHsDPW3v1B6kgS5XzKTzBa0oh7XM2HSojTK+OuNul97aeTSE
         Lr1klIo64cUSC/rGzyyW0vnBJRoVmru4zaKQ6cR/awjjmv1JxvqRTeJnZTrpC80LYttf
         At/yrifuMfaTrVEV7MT9hQvHDz+hj0bf/w4YnDqs8w9xEvhrTmbtAwR6WgU7N3t2j5qk
         PirW7MAqVWOrOXMsRumq2uQ5jXVHLEWs1D09TxlWkzdqJKyTj8paAtCyRfaLX2FibitT
         kPmuFecKLTPcQWFZ4nRNrHUrkHmprgPBqxIURh6z3VBvhbifgD+MQHBQqAXiugonw+fO
         m6/A==
X-Forwarded-Encrypted: i=1; AJvYcCW22109sZppNdHub9G18sf4tCsM7t2yB2QiuDPycYB7VohZWwQx1BpezRZoAQYZkbBqTveIt41S/AHeh9z9oFn+7RLyLYICVPMRffUx0GbqXHnFjsb6GTsvfLFGxN8Au0qPYVbvov+F30YuNu5XQA==
X-Gm-Message-State: AOJu0YygS2uctlZ8ab1JWrvaxPSrS0y9JPtLcJkzRNC+JjbM3wYEFj+y
	2WXxnADyWDLxTvd+nLflR1INHhsz9SM3By001Q854/71Oud9ebun
X-Google-Smtp-Source: AGHT+IFweo3u2/cBYbxTGLzmbhOIxRTyQMFZGoj3lxZwVWrXoZDdCk/aA6BmE3xnMJUJxDKXy90lNQ==
X-Received: by 2002:a05:6a20:dd9e:b0:1af:d19b:a78 with SMTP id adf61e73a8af0-1afde0b7245mr9666032637.13.1715633107502;
        Mon, 13 May 2024 13:45:07 -0700 (PDT)
Received: from gmail.com ([50.204.89.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886b669sm10170490a91.24.2024.05.13.13.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 13:45:07 -0700 (PDT)
Date: Mon, 13 May 2024 21:45:05 +0100
From: Breno Leitao <leitao@debian.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>, leit@meta.com,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>,
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf list: Fix the --no-desc option
Message-ID: <ZkJ70SOeVPsLRuS1@gmail.com>
References: <20240508133518.3204221-1-leitao@debian.org>
 <Zj-WE1aG7ihtevG3@x1>
 <CAP-5=fXXYVgb4rnftaiTZTEniGOr5NnpfXJFNqX96GXP6=oTiA@mail.gmail.com>
 <Zj-qIbUN2XFBnvP8@x1>
 <ZkJI6Q6KVKlzDgSQ@gmail.com>
 <CAP-5=fU=tG9Gk+OfO3TVfBONTc35oksNqi3xm6Y_hjc0oOK=dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU=tG9Gk+OfO3TVfBONTc35oksNqi3xm6Y_hjc0oOK=dw@mail.gmail.com>

On Mon, May 13, 2024 at 10:13:01AM -0700, Ian Rogers wrote:
> On Mon, May 13, 2024 at 10:08 AM Breno Leitao <leitao@debian.org> wrote:
> > On Sat, May 11, 2024 at 02:25:53PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Thanks for asking the question, I'm dropping the patch, Breno, can you
> > > try again?
> >
> > Sure, let me think about it and send a v2.
> 
> Thanks Breno! My bug, thanks for digging into this.

How about something like this:

Author: Breno Leitao <leitao@debian.org>
Date:   Wed May 8 06:35:17 2024 -0700

    perf list: Fix the --no-desc option
    
    Currently, the --no-desc option in perf list isn't functioning as
    intended.
    
    This issue arises from the overwriting of struct option->desc with the
    opposite value of struct option->long_desc. Consequently, whatever
    parse_options() returns at struct option->desc gets overridden later,
    rendering the --desc or --no-desc arguments ineffective.
    
    To resolve this, set ->desc as true by default and allow parse_options()
    to adjust it accordingly. This adjustment will fix the --no-desc
    option while preserving the functionality of the other parameters.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
index e27a1b1288c2..16186acdd301 100644
--- a/tools/perf/builtin-list.c
+++ b/tools/perf/builtin-list.c
@@ -149,7 +149,11 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 	} else
 		fputc('\n', fp);
 
-	if (desc && print_state->desc) {
+	if (long_desc && print_state->long_desc) {
+		fprintf(fp, "%*s", 8, "[");
+		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
+		fprintf(fp, "]\n");
+	} else if (desc && print_state->desc) {
 		char *desc_with_unit = NULL;
 		int desc_len = -1;
 
@@ -165,12 +169,6 @@ static void default_print_event(void *ps, const char *pmu_name, const char *topi
 		fprintf(fp, "]\n");
 		free(desc_with_unit);
 	}
-	long_desc = long_desc ?: desc;
-	if (long_desc && print_state->long_desc) {
-		fprintf(fp, "%*s", 8, "[");
-		wordwrap(fp, long_desc, 8, pager_get_columns(), 0);
-		fprintf(fp, "]\n");
-	}
 
 	if (print_state->detailed && encoding_desc) {
 		fprintf(fp, "%*s", 8, "");
@@ -484,6 +482,7 @@ int cmd_list(int argc, const char **argv)
 	int i, ret = 0;
 	struct print_state default_ps = {
 		.fp = stdout,
+		.desc = true,
 	};
 	struct print_state json_ps = {
 		.fp = stdout,
@@ -556,7 +555,6 @@ int cmd_list(int argc, const char **argv)
 		};
 		ps = &json_ps;
 	} else {
-		default_ps.desc = !default_ps.long_desc;
 		default_ps.last_topic = strdup("");
 		assert(default_ps.last_topic);
 		default_ps.visited_metrics = strlist__new(NULL, NULL);
