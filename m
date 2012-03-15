From: Arun Sharma <asharma@fb.com>
Subject: Re: [PATCH] perf: Add a new sort order: SORT_INCLUSIVE (v5)
Date: Thu, 15 Mar 2012 10:42:34 -0700
Message-ID: <4F622A0A.30406@fb.com>
References: <1331832848-17028-1-git-send-email-asharma@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331832848-17028-1-git-send-email-asharma@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arun Sharma <asharma@fb.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Arnaldo Carvalho de Melo <acme@redhat.com>, Frederic Weisbecker <fweisbec@gmail.com>, Mike Galbraith <efault@gmx.de>, Paul Mackerras <paulus@samba.org>, Peter Zijlstra <peterz@infradead.org>, Stephane Eranian <eranian@google.com>, Namhyung Kim <namhyung.kim@lge.com>, Tom Zanussi <tzanussi@gmail.com>, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org


This is just a rebase to tip:perf/core. No logic changes since v4 (which 
Namhyung reviewed).

Had to resolve some merge conflicts with the sort__branch_mode.

  -Arun
