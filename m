From: Tony Jones <tonyj@suse.de>
Subject: [PATCH 00/15] perf script python: add Python3 support
Date: Fri, 22 Feb 2019 15:06:04 -0800
Message-ID: <20190222230619.17887-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org
List-Id: linux-perf-users.vger.kernel.org

The following patches add Python3 support to the remainder of 
the scripts under scripts/python.

Minimum supported Python version is now v2.6

I tested everything against v2.7 (no patch), v2.7 (patch) and 
v3.7 (patch).  Seeteena also tested a subset (no SQL, no IPT) 
against v2.6

There are changes in order of output as key ordering is not 
consistent between v2 and v3 but format of each line should be 
unchanged.
