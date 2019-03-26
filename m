From: Andi Kleen <andi@firstfloor.org>
Subject: perf: Add duration_time to perf stat
Date: Tue, 26 Mar 2019 15:18:19 -0700
Message-ID: <20190326221823.11518-1-andi@firstfloor.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: acme@kernel.org
Cc: jolsa@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Currently it's not possible to get the wall clock time of a measurement
in CSV mode output, it's only in the non CSV perf stat output.
Often this is needed to normalize event counts to time.

Add a new duration_time event that can be specified and reports
the wall clock time in ns.
