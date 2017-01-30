From: Taeung Song <taeung@kosslab.kr>
Subject: [Question] About '(*idx)++' of perf_evsel__new_idx
Date: Mon, 30 Jan 2017 11:53:18 +0900
Message-ID: <1f6c94c2-1e9d-a85d-b4b6-ad47510d4d3f@kosslab.kr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35448 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdA3DAz (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sun, 29 Jan 2017 22:00:55 -0500
Received: by mail-pf0-f169.google.com with SMTP id f144so86729262pfa.2
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Jan 2017 19:00:54 -0800 (PST)
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: perf group <linux-perf-users@vger.kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim <namhyung@kernel.org>

Hi, :)

Can I ask you one thing ?

I'm reading source code util/parse-event.c
Along the way, I wonder why increase idx before checking
whether 'evsel' is NULL or not ? (at 310,311 line number)


300 static struct perf_evsel *
301 __add_event(struct list_head *list, int *idx,
302             struct perf_event_attr *attr,
303             char *name, struct cpu_map *cpus,
304             struct list_head *config_terms)
305 {
306         struct perf_evsel *evsel;
307
308         event_attr_init(attr);
309
310         evsel = perf_evsel__new_idx(attr, (*idx)++);
311         if (!evsel)
312                 return NULL;
313
314         evsel->cpus     = cpu_map__get(cpus);
315         evsel->own_cpus = cpu_map__get(cpus);
316

IMHO, if 'evsel' isn't NULL, we can increase idx like below.

             evsel = perf_evsel__new_idx(attr, *idx);
             if (!evsel)
                     return NULL;
             else
                (*idx)++;

Is it wrong ? or is there other reason about increasing idx
before check 'evsel'?

Thanks,
Taeung
