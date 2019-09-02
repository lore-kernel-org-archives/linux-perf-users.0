From: James Clark <James.Clark@arm.com>
Subject: [PATCH v2 0/1] perf tools: Add PMU event JSON files for ARM
 Cortex-A76 and, Neoverse N1.
Date: Mon, 2 Sep 2019 16:08:13 +0000
Message-ID: <20190902160713.1425-1-james.clark@arm.com>
References: <00f00310-09ae-909c-4dfd-021996e45be1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <00f00310-09ae-909c-4dfd-021996e45be1@arm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: nd <nd@arm.com>, James Clark <James.Clark@arm.com>
List-Id: linux-perf-users.vger.kernel.org

Resubmitting due to the previous patch having a disclaimer appended.
I've tested that this applies cleanly with git am.

James Clark (1):
  perf tools: Add PMU event JSON files for ARM Cortex-A76 and, Neoverse
    N1.

 .../arch/arm64/arm/cortex-a76-n1/branch.json  |  14 ++
 .../arch/arm64/arm/cortex-a76-n1/bus.json     |  24 ++
 .../arch/arm64/arm/cortex-a76-n1/cache.json   | 207 ++++++++++++++++++
 .../arm64/arm/cortex-a76-n1/exception.json    |  52 +++++
 .../arm64/arm/cortex-a76-n1/instruction.json  | 108 +++++++++
 .../arch/arm64/arm/cortex-a76-n1/memory.json  |  23 ++
 .../arch/arm64/arm/cortex-a76-n1/other.json   |   7 +
 .../arm64/arm/cortex-a76-n1/pipeline.json     |  14 ++
 tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +
 9 files changed, 451 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bran=
ch.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/bus.=
json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/cach=
e.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/exce=
ption.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/inst=
ruction.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/memo=
ry.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/othe=
r.json
 create mode 100644 tools/perf/pmu-events/arch/arm64/arm/cortex-a76-n1/pipe=
line.json

--=20
2.23.0
